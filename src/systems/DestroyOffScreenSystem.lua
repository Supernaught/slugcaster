--
-- DestroyOffScreenSystem
-- by Alphonsus
--
-- removes objects off the world if they go beyond the screen
--

local DestroyOffScreenSystem = tiny.processingSystem(class "DestroyOffScreenSystem")

DestroyOffScreenSystem.filter = tiny.requireAll("destroyOffScreen", "pos")

function DestroyOffScreenSystem:process(e, dt)
	if (e.pos.x < -100 or e.pos.x > (push:getWidth()+100)) or (e.pos.y < -100 or e.pos.y > (push:getHeight()+100)) then
		e.isAlive = false
		world:remove(e)
	end
end

return DestroyOffScreenSystem