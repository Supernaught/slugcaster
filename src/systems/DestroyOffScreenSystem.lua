--
-- DestroyOffScreenSystem
-- by Alphonsus
--
-- removes objects off the world if they go beyond the screen
--

local DestroyOffScreenSystem = tiny.processingSystem(class "DestroyOffScreenSystem")

DestroyOffScreenSystem.filter = tiny.requireAll("destroyOffScreen", "pos")

function DestroyOffScreenSystem:process(e, dt)
	if (e.pos.x < -12 or e.pos.x > (push:getWidth()+12)) or (e.pos.y < -12 or e.pos.y > (push:getHeight()+12)) then
		e.isAlive = false
		world:remove(e)
	end
end

return DestroyOffScreenSystem