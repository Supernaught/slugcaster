menustate = {}

local flux = require "lib.flux"
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

	local pressStartUI = UIText("PRESS START", 0, push:getHeight() * 0.75, push:getWidth(), nil, nil, assets.font_sm)
	pressStartUI.blinking = true
	pressStartUI.blinkDelay = 0.5

	-- local credits = UIText("PRESS START", 0, push:getHeight() * 0.7, push:getWidth(), nil, nil, assets.alt_font_sm)

	titleImage = UIImage(assets.title2, "center", -30)

	self.world = tiny.world(
		require("src.systems.BGColorSystem")(32,70,49),
		require("src.systems.BlinkingSystem")(),
		require("src.systems.UpdateSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.MovableSystem")(),
		require("src.systems.DrawUISystem")("hudForeground"),
		-- frontBg,
		-- frontBg2,
		-- backBg,
		-- backBg2,
		titleImage,
		pressStartUI
	)

	flux.to(titleImage.pos, 1.5, {y = 25})

	world = self.world
    PaletteSwitcher.next()
end

function menustate:update(dt)
	if love.keyboard.isDown("space") then
		Gamestate.switch(PlayState)
	end

	flux.update(dt)
end

function menustate:draw()
end

return menustate
