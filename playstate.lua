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

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(156,189,22),
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
end

function playstate:draw()
	push:apply("start")
	push:apply("end")	

	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nEntities: " .. world:getEntityCount(), 5, 5)
end

return playstate