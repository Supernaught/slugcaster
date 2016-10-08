--
-- Animating static water
-- by Alphonsus
--
-- spawn enemies randomly
--

local Water = GameObject:extend()
local vector = require "lib.hump.vector"
local assets =  require "src.assets"

function Water:new(x, y)
	Water.super.new(self, x, y)
	self.name = "Water"
	self.isWater = true

	-- sprite/animation component
	self.sprite = assets.water
	-- self.offset = { x = 6, y = 6 }
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-4',1), 0.1)

	return self
end

return Water