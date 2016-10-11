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

function playstate:enter()
	HC = HClib.new(150)
	player = Player()

	timer.clear()
	score = 0

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
	if love.keyboard.isDown("q") then
		Gamestate.switch(menustate)
	end

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
	-- local textscale = 1
	-- love.graphics.setFont(assets.alt_font_sm)
	-- love.graphics.printf("SCORE: " .. score, 0, 50, push:getWidth(), "center", 0, textscale,textscale)
	-- love.graphics.printf("HI-SCORE: 100", 0, 62, push:getWidth(), "center", 0, textscale,textscale)
    love.graphics.draw(smokePs, 0, 0, 0, 1, 1)
	push:apply("end")

	PaletteSwitcher:set()
	PaletteSwitcher:unset()
end

function playstate.getPlayer()
	return player
end

function playstate.addScore(n)
	score = score + (n or 1)

	if score % 20 == 0 then
		world:add(EnemyWalkerShooter())
	end

	if score % 10 == 0 and score < 50 then
		spawner.spawnDelayMin = spawner.spawnDelayMin - 0.02
		spawner.spawnDelayMax = spawner.spawnDelayMax - 0.12
	end
end

return playstate
