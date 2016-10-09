--
-- Water splash
-- by Alphonsus
--

local Water = GameObject:extend()
local vector = require "lib.hump.vector"
local assets =  require "src.assets"

function Water:new(x, y)
	Water.super.new(self, x, y)
	self.name = "Water"
	self.isWater = true

	-- sprite/animation component
	self.sprite = assets.splash
	-- self.offset = { x = 6, y = 6 }
	local frameDuration = 0.04
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-5',1), frameDuration)

	timer.after((frameDuration*4), function() self.toRemove = true end)

	return self
end

function Water:update(dt)
end

return Water
