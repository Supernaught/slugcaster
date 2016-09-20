local DrawUISystem = tiny.processingSystem(class "DrawUISystem")

function DrawUISystem:init(layerFlag)
	self.filter = tiny.requireAll("drawHud", layerFlag)
end

function DrawUISystem:process(e, dt)
	e:drawHud(dt)
end

return DrawUISystem