menustate = {}

local UIText = require "src.entities.UIText"
local PlayState = require "playstate"
local assets =  require "src.assets"

local title, pressToPlay
local dir = 1

function menustate:init()
	self.world = tiny.world(
		require("src.systems.BGColorSystem")(0,0,10),
		require("src.systems.DrawUISystem")("hudForeground"),

		UIText("GBJAM5", 0, push:getHeight() * 0.2, push:getWidth(), nil, nil, assets.font_md),
		UIText("PRESS START", 0, push:getHeight() * 0.7, push:getWidth(), nil, nil, assets.alt_font_sm)
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