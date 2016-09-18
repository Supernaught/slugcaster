local Object = require "lib.classic"
local Transform = require "alph.comp.Transform"

local Entity = Object:extend()

-- Add components
Entity:implement(Transform) -- entities have x,y,w,h by default

-- Functions
function Entity:new(x,y,width,height)
	-- Entity data
	self.components = {}
	self.toRemove = false

	-- Init components
	self.transform = self:initTransform(x,y,width,height)

	return self
end

function Entity:update(dt)
	for _,component in pairs(self.components) do
		component.update(dt)
	end
end

function Entity:draw()
end

return Entity