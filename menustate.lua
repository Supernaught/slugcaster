menustate = {}

local UIText = require "src.entities.UIText"
local MovingParallaxBG = require "src.entities.MovingParallaxBG"
local assets =  require "src.assets"

local title, pressToPlay
local dir = 1

function menustate:enter()
	local xSpeed = -5
	local frontBg = MovingParallaxBG(assets.bg, 0, 'floatBottom', xSpeed)
	local frontBg2 = MovingParallaxBG(assets.bg, push:getWidth(), 'floatBottom', xSpeed, frontBg)

	local xSpeed = -15
	local backBg = MovingParallaxBG(assets.bg2, 0, 'floatBottom', xSpeed)
	local backBg2 = MovingParallaxBG(assets.bg2, push:getWidth(), 'floatBottom', xSpeed, backBg)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(32,70,49),
		require("src.systems.UpdateSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		frontBg,
		frontBg2,
		backBg,
		backBg2,
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