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
	self.sprite = assets.player
	self.offset = { x = 4, y = 4 }
	self.flippedH = false
	local g = anim8.newGrid(_G.TILE_SIZE, _G.TILE_SIZE, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-3',1), 0.1)

	-- destroy after (secs per frame * no of frames)
	timer.after(0.2, function() self.toRemove = true end)

	return self
end

function Explosion:update(dt)
end

return Explosion
