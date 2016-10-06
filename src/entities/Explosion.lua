--
-- Explosion
--

local Explosion = GameObject:extend()
local assets =  require "src.assets"

function Explosion:new(x, y)
	Explosion.super.new(self, x, y)

	-- entity
	self.name = "Explosion"
	self.isExplosion = true

	-- Explosion
	self.sprite = assets.explosion
	self.offset = { x = 4, y = 4 }
	self.flippedH = false
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	if(math.random(0, 2) == 1) then
		self.animation = anim8.newAnimation(g('1-8',1), 0.045, 'pauseAtEnd')
	else
		self.animation = anim8.newAnimation(g('1-8',2), 0.045, 'pauseAtEnd')
	end

	-- destroy after (secs per frame * no of frames)
	timer.after((0.045*8), function() self.toRemove = true end)

	return self
end

function Explosion:update(dt)
end

return Explosion
