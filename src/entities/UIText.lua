local UIText = Object:extend()

function UIText:drawHud()
	if self.font then
		love.graphics.setFont(self.font)
	else
		love.graphics.setFont(love.graphics.newFont(self.fontSize))
	end

	love.graphics.printf(self.text, self.pos.x, self.pos.y, self.width, self.align)
end

function UIText:new(text, x, y, width, align, fontSize, font)

	-- Draw UI System
	self.pos = {x = x or 0, y = y or 0}
	self.text = text or ""
	self.width = width or love.graphics.getWidth()
	self.align = align or "center"
	self.fontSize = fontSize or 20
	self.font = font or nil
	self.hudForeground = true
	self.inCamera = false

	return self
end

return UIText