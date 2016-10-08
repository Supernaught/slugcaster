--
-- MovingParallaxBG
-- by Alphonsus
--
-- bg image moving sideways
-- loops when reach off screen
--

local MovingParallaxBG = GameObject:extend()
local lume = require "lib.lume"
local assets = require "src.assets"

function MovingParallaxBG:new(sprite, x, y, speed, pair)
	MovingParallaxBG.super.new(self, x, y)
	self.name = "MovingParallaxBG"
	self.isMovingParallaxBG = true

	-- movable component
	self.movable = {
		velocity = { x = speed or -20, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 }, -- 80 = gravity
		maxVelocity = { x = 0, y = 0 },
		speed = { x = 0, y = 0 } -- used to assign to acceleration
	}

	self.sprite = sprite or assets.bg

	if type(y) == 'string' then
		self.pos.y = push:getHeight() - self.sprite:getHeight()
	end

	if pair then
		self.pos.x = pair.sprite:getWidth()
	end

	return self
end

function MovingParallaxBG:update(dt)
	if pair then
		self.pos.x = pair.sprite:getWidth() - 2
	end

	if self.pos.x + push:getWidth() <= 0 then
		if pair then
			self.pos.x = pair.pos.x + pair.sprite.getWidth()
		else
			self.pos.x = push:getWidth() - 2
		end
	end
end

return MovingParallaxBG