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
	self.filter = tiny.requireAll("shooter", "shoot")
end

function ShooterSystem:process(e, dt)
	local s = e.shooter

	if s.shoot then
		s.shoot = false

		if s.canAtk then
			e:shoot(dt)
			s.canAtk = false
			timer.after(s.atkDelay, function() s.canAtk = true end)
		end
	end
end

return ShooterSystem
