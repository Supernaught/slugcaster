local Player = Object:extend()
local assets =  require "src.assets"

function Player:new(x,y)
	self.pos = {x = x or 0, y = y or 0}
	self.scale = {}
	self.rot = 0
	self.offset = {x = 0, y = 0}

	return self
end

function Player:update(dt)
	self.rot = self.rot + 1 * dt
end

return Player