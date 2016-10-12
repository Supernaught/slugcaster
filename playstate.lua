-- playstate
playstate = {}

-- entities
local Player = require "src.entities.Player"
local Enemy = require "src.entities.Enemy"
local EnemyWalkerShooter = require "src.entities.EnemyWalkerShooter"
local Spawner = require "src.entities.Spawner"
local Water = require "src.entities.Water"
local UIImage = require "src.entities.UIImage"

-- libs
local HClib = require "lib.hc"

local player
local uiScore
local score = 0

HC = nil

local assets = require "src.assets"
local spawner
local showScores = false
local newHighscore = false
local hiscore = 0

function playstate:enter()
	HC = HClib.new(150)
	player = Player()

	timer.clear()
	score = 0
	showScores = false
	newHighscore = false

	for i, score, name in highscore() do
	    hiscore = score
	end

	self.setupExplosionSmokeParticles()

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(32,70,49),
		require("src.systems.UpdateSystem")(),
		require("src.systems.DrawSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.MoveTowardsTargetSystem")(),
		require("src.systems.CollisionSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.ShooterSystem")(),
		require("src.systems.DestroyOffScreenSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		UIImage(assets.level160, 0, 0),
		player
	)

	spawner = Spawner()

	world = self.world
	world:add(spawner)

	-- add water
	for i=math.floor(push:getWidth()/12),0,-1
	do
		world:add(Water(12 * i,120))
	end
end

function playstate:update(dt)
	smokePs:update(dt)
end

function playstate:setupExplosionSmokeParticles()
	smokePs = love.graphics.newParticleSystem(assets.smoke, 100)
	smokePs:setPosition(push:getWidth()/2, push:getHeight()/2)
	smokePs:setParticleLifetime(0.5, 1.2)
	smokePs:setDirection(1.5*3.14)
	smokePs:setSpread(3.14/3)
	smokePs:setSpeed(10, 800)
	smokePs:setLinearAcceleration(0, -600)
	smokePs:setLinearDamping(50)
	smokePs:setSpin(0, 30)
	smokePs:setColors(82, 127, 57, 255);
	smokePs:setRotation(0, 2*3.14)
	smokePs:setSizes(.5, 0)
	smokePs:setInsertMode('random')
end

function playstate:draw()
	PaletteSwitcher:set()
	push:apply("start")
    love.graphics.draw(smokePs, 0, 0, 0, 1, 1)
	love.graphics.setFont(assets.alt_font_sm)

	if showScores then
		love.graphics.setColor(255,1,1)
		love.graphics.printf("SCORE: " .. score, 0, 60, push:getWidth(), "center")
		love.graphics.setColor(100,1,1)
		if newHighscore then
			love.graphics.printf("NEW HI-SCORE!", 0,72, push:getWidth(), "center")
		else
			love.graphics.printf("HI-SCORE: " .. hiscore, 0, 72, push:getWidth(), "center")
		end
	else
		love.graphics.setColor(255,1,1)
		love.graphics.printf("SCORE " .. score, 0, push:getHeight() - 18, push:getWidth(), "center")
		love.graphics.setColor(100,1,1)
		if newHighscore then
			love.graphics.printf("NEW HI-SCORE!", 0, push:getHeight() - 9, push:getWidth(), "center")
		else
			love.graphics.printf("HI-SCORE " .. hiscore, 0, push:getHeight() - 9, push:getWidth(), "center")
		end
	end

	push:apply("end")

	PaletteSwitcher:set()
	PaletteSwitcher:unset()
end

function playstate.getPlayer()
	return player
end

function playstate.addScore(n)
	score = score + (n or 1)

	if score > hiscore then
		newHighscore = true
	end

	if score % 20 == 0 then
		world:add(EnemyWalkerShooter())
	end

	if score % 10 == 0 and score < 50 then
		spawner.spawnDelayMin = spawner.spawnDelayMin - 0.02
		spawner.spawnDelayMax = spawner.spawnDelayMax - 0.12
	end
end

function playstate.gameover()
	timer.after(1.5, function() showScores = true end)

	if score > hiscore then
		newHighscore = true
		highscore.add("", score)
		highscore.save()
	end
end

function playstate:keypressed(k)
	if showScores and (k == 'space' or k == 'return') then
		showScores = false
		Gamestate.switch(menustate)
	else
		if k == 'q' then
			Gamestate.switch(menustate)
		end
	end		
end

return playstate
