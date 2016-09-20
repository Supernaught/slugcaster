local BGColorSystem = tiny.system(class "BGColorSystem")

function BGColorSystem:init(r, g, b)
	self.r, self.g, self.b = r, g, b
end

function BGColorSystem:update(dt)
	if camera then camera:detach() end

	local r1, g1, b1, a = love.graphics.getColor()
	love.graphics.setColor(self.r, self.g, self.b, 255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(r1, g1, b1, a)

	if camera then camera:attach() end
end

return BGColorSystem
