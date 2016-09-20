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
		require("src.systems.UpdateSystem")(),
		require("src.systems.BGColorSystem")(20,0,0),
		require("src.systems.DrawUISystem")("hudForeground"),
		player
	)

	world = self.world
end

function playstate:update(dt)
end

function playstate:draw()
end

return playstate