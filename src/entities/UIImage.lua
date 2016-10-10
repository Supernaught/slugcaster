local UIImage = Object:extend()

function UIImage:drawHud()
	if self.visible == false then
        return
    end

	love.graphics.draw(self.image, self.pos.x, self.pos.y, nil, self.scale.x, self.scale.y)
end

function UIImage:new(image, x, y, sx, sy)
	self.visible = true

	-- Draw UI System
	self.pos = {x = 0, y = 0}
	self.image = image
	self.hudForeground = true
	self.scale = {x = sx or 1, y = sx or 1}

	if type(x) == 'string' and x == "center" then
		self.pos.x = (push:getWidth()/2 - image:getWidth()/2) * self.scale.x
	else
		self.pos.x = x
	end

	if type(y) == 'string' and y == "center" then
		self.pos.y = push:getHeight()/2 - image:getHeight()/2
	else
		self.pos.y = y
	end


	return self
end

return UIImage