menustate = {}

local UIText = require "src.entities.UIText"
local PlayState = require "playstate"

local title, pressToPlay
local dir = 1

function menustate:init()
	self.world = tiny.world(
		require("src.systems.BGColorSystem")(0,0,10),
		require("src.systems.DrawUISystem")("hudForeground"),
		UIText("GAME TITLE", 0, push:getHeight() * 0.2, push:getWidth(), nil, 24),
		UIText("Press SPACE to start", 0, push:getHeight() * 0.7, push:getWidth(), nil, 12)
	)

	world = self.world
end

function menustate:update(dt)
	if love.keyboard.isDown("space") then
		Gamestate.switch(PlayState)
	end
end

function menustate:draw()
end

return menustate