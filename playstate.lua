-- play state

playstate = {}

local Player = require "src.entities.Player"
local Camera = require "lib.hump.camera"

local player
local uiScore
local score = 0

function playstate:init()
	player = Player()
	camera = Camera(0, 0, 1)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(20,0,0),
		require("src.systems.UpdateSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		player
	)

	world = self.world
end

function playstate:update(dt)
end

function playstate:draw()
	love.graphics.print("Hello world, this is the playstate.lua with a Player entity", 20, 20)
end

return playstate