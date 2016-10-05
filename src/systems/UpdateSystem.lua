local UpdateSystem = tiny.processingSystem(class "UpdateSystem")

UpdateSystem.filter = tiny.requireAll("update")

function UpdateSystem:process(e, dt)
	if e.toRemove then
		print(e.name)
		world:remove(e)
		e.isAlive = false
	else
		e:update(dt)
	end
end

return UpdateSystem