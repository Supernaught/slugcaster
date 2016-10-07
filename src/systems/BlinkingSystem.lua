--
-- BlinkingSystem
-- by Alphonsus
--
-- removes objects off the world if they go beyond the screen
--

local BlinkingSystem = tiny.processingSystem(class "BlinkingSystem")

BlinkingSystem.filter = tiny.requireAll("blinking")

function BlinkingSystem:onAdd(e)
	timer.script(function(wait)
	    while true do
	        self.blink(e)
	        wait(e.blinkDelay)
	    end
	end)	
end

function BlinkingSystem.blink(e)
	if e.visible then
		e.visible = false
	else
		e.visible = true
	end
end

return BlinkingSystem