-- playstate
playstate = {}

-- entities
local Player = require "src.entities.Player"
local Enemy = require "src.entities.Enemy"
local Spawner = require "src.entities.Spawner"
local EnemyBullet = require "src.entities.EnemyBullet"

-- libs
local Camera = require "lib.hump.camera"
local HClib = require "lib.hc"

local player
local uiScore
local score = 0

HC = nil

local assets = require "src.assets"

function playstate:enter()
	HC = HClib.new(150)
	player = Player()
	camera = Camera(0, 0, 1)

	timer.clear()

	self.setupExplosionSmokeParticles()

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(32,70,49),
		require("src.systems.UpdateSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.MoveTowardsTargetSystem")(),
		require("src.systems.CollisionSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.ShooterSystem")(),
		require("src.systems.DestroyOffScreenSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		EnemyBullet(10,10),
		player
	)

	world = self.world
	world:add(Spawner())
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
  smokePs:setRotation(0, 2*3.14)
	smokePs:setSizes(.5, 0)
  smokePs:setInsertMode('random')
end

function playstate:draw()
	push:apply("start")
    love.graphics.draw(smokePs, 0, 0, 0, 1, 1)
	push:apply("end")

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nEntities: " .. world:getEntityCount(), 5, 5)
end

function playstate.getPlayer()
	return player
end

return playstate
