-- 
-- MoveTowardsAngleSystem
-- by Alphonsus
--
-- set velocity towards angle
--

local MoveTowardsAngleSystem = tiny.processingSystem(class "MoveTowardsAngleSystem")

MoveTowardsAngleSystem.filter = tiny.requireAll("moveTowardsAngle", "movable")

function MoveTowardsAngleSystem:process(e, dt)
	e.movable.velocity.x = math.cos(e.angle - math.rad(90)) * e.speed
	e.movable.velocity.y = math.sin(e.angle - math.rad(90)) * e.speed
end

return MoveTowardsAngleSystem