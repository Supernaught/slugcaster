local Object = require "lib.classic"

World = Object:extend()

function World:new()
	self.entities = {}
	return self
end

function World:add(obj)
	table.insert(self.entities, obj)
	return obj
end

function World:update(dt)
	for i,entity in ipairs(self.entities) do
		if not entity.toRemove then
			if entity.update then entity:update(dt) end
		else
			table.remove(self.entities, i)
		end
	end
end

function World:draw()
end

return World