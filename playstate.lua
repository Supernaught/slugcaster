-- playstate
playstate = {}

-- entities
local Player = require "src.entities.Player"
local Enemy = require "src.entities.Enemy"
local Spawner = require "src.entities.Spawner"
-- libs
local Camera = require "lib.hump.camera"
local HClib = require "lib.hc"

local player
local uiScore
local score = 0

HC = nil

local assets = require "src.assets"

function playstate:enter()
	player = Player()
	camera = Camera(0, 0, 1)

	HC = HClib.new(150)

	self.setupEnemyCorpseParticles()

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(32,70,49),
		require("src.systems.UpdateSystem")(),
		require("src.systems.MoveTowardsAngleSystem")(),
		require("src.systems.CollisionSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.ShooterSystem")(),
		require("src.systems.DestroyOffScreenSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		player
	)

	world = self.world
	world:add(Spawner())
end

function playstate:update(dt)
	if love.keyboard.isDown("q") then
		Gamestate.switch(menustate)
	end

	corpsePs:update(dt)
end

function playstate:setupEnemyCorpseParticles()
	corpsePs = love.graphics.newParticleSystem(assets.shells, 100)
	corpsePs:setPosition(push:getWidth()/2, push:getHeight()/2)
	corpsePs:setParticleLifetime(0.5, 1)
    corpsePs:setDirection(1.5*3.14)
    corpsePs:setSpread(3.14/3)
    corpsePs:setSpeed(10, 150)
    corpsePs:setLinearAcceleration(0, 300)
    corpsePs:setLinearDamping(0.5)
    corpsePs:setSpin(3, 15)
    corpsePs:setRotation(0, 2*3.14)
    corpsePs:setInsertMode('random')
end

function playstate:draw()
	push:apply("start")
    love.graphics.draw(corpsePs, 0, 0, 0, 1, 1)
	push:apply("end")

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nEntities: " .. world:getEntityCount(), 5, 5)
end

return playstate
