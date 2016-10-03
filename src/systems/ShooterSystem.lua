-- 
-- ShooterSystem
-- by Alphonsus
--
-- Required:
--
-- self.shooter = {
--		atkDelay = 0.05,
-- 		canAtk = true,
-- 		shoot = false
-- 	}
--
-- Usage: To shoot, set entity.shooter.shoot to true
--

local ShooterSystem = tiny.processingSystem(class "ShooterSystem")
local Bullet = require "src.entities.Bullet"

function ShooterSystem:init()
	self.filter = tiny.requireAll("shooter")
end

function ShooterSystem:process(e, dt)
	local s = e.shooter

	if s.shoot then
		s.shoot = false

		if s.canAtk then
			self:shoot(e, dt, s)
		end
	end
end

-- actually fire a bullet
function ShooterSystem:shoot(e, dt, s)
	world:addEntity(Bullet(e.pos.x, e.pos.y, e.angle + math.rad(180)))

	s.canAtk = false
	timer.after(s.atkDelay, function() s.canAtk = true end)
end

return ShooterSystem