local UIText = Object:extend()

function UIText:drawHud()
	-- if doDetach then camera:detach() end
	love.graphics.setFont(love.graphics.newFont(self.fontSize))
	love.graphics.printf(self.text, self.pos.x, self.pos.y, self.width, self.align)
	-- if doDetach then camera:attach() end
end

function UIText:new(text, x, y, width, align, fontSize)
	self.pos = {x = x or 0, y = y or 0}
	self.text = text or ""
	self.width = width or love.graphics.getWidth()
	self.align = align or "center"
	self.fontSize = fontSize or 20
	self.hudForeground = true
	self.inCamera = false

	return self
end

return UIText