-- 
-- Transform component
-- by Alphonsus
--

local Object = require "lib.classic"

local Transform = Object:extend()

function Transform:new()
end

function Transform:initTransform(x,y,w,h)
	self.width = w or 16
	self.height = h or 16
	self.x = x or 0
	self.y = y or 0

	return self
end

return Transform