menustate = {}

local UIText = require "src.entities.UIText"
local UIImage = require "src.entities.UIImage"
local MovingParallaxBG = require "src.entities.MovingParallaxBG"
local assets =  require "src.assets"

local title, pressToPlay
local dir = 1

local titleImage

function menustate:enter()
	timer.clear()

	local xSpeed = -50
	local frontBg = MovingParallaxBG(assets.bg, 0, 'floatBottom', xSpeed)
	local frontBg2 = MovingParallaxBG(assets.bg, push:getWidth(), 'floatBottom', xSpeed, frontBg)

	local xSpeed2 = -90
	local backBg = MovingParallaxBG(assets.bg2, 0, 'floatBottom', xSpeed2)
	local backBg2 = MovingParallaxBG(assets.bg2, push:getWidth(), 'floatBottom', xSpeed2, backBg)

	local pressStartUI = UIText("PRESS START", 0, push:getHeight() * 0.7, push:getWidth(), nil, nil, assets.alt_font_sm)
	pressStartUI.blinking = true
	pressStartUI.blinkDelay = 0.5

	titleImage = UIImage(assets.title, "center", 35)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(32,70,49),
		require("src.systems.BlinkingSystem")(),
		require("src.systems.UpdateSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		frontBg,
		frontBg2,
		backBg,
		backBg2,
		titleImage,
		-- UIText("SLUGCASTER", 0, push:getHeight() * 0.2, push:getWidth(), nil, nil, assets.font_sm),
		pressStartUI
	)

	world = self.world
end

function menustate:update(dt)
	if love.keyboard.isDown("space") then
		Gamestate.switch(PlayState)
	end

	titleImage.pos.x = titleImage.pos.x + 0.1
end

function menustate:draw()
end

return menustate
