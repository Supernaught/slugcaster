local GameObject = Object:extend()
local assets = require "src.assets"

function GameObject:new(x,y)
	-- gameobject
	self.name = "GameObject"
	self.isAlive = true
	self.toRemove = false

	-- transform
	self.pos = { x = x or 0, y = y or 0 }
	self.offset = { x = 0, y = 0}
	self.scale = {}
	self.angle = 0 -- in radians

	return self
end

return GameObject