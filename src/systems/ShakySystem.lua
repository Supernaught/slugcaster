local Shaky = tiny.processingSystem(class "Shaky")
local lume = require "lib.lume"

function Shaky:init()
	self.filter = tiny.requireAll("shakyX", "shakyY", "pos")
end

function Shaky:onAdd(e)
	e.dir = 1
	e.origPosX = e.pos.x
	e.origPosY = e.pos.y
end

function Shaky:process(e, dt)
	-- if dir == 1 and e.pos.y >= 170 then
	-- 	dir = -1
	-- elseif dir == -1 and e.pos.y <= 150 then
	-- 	dir = 1
	-- end

	-- e.pos.y = e.pos.y + 100 * dt * dir

	e.pos.x = e.origPosX + lume.random(-e.shakyX, e.shakyX)
	e.pos.y = e.origPosY + lume.random(-e.shakyY, e.shakyY)
end

return Shaky