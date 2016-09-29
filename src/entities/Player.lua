GameObject = require "src.entities.GameObject"

local Player = GameObject:extend()
local assets =  require "src.assets"

function Player:new()
	Player.super.new(self, push:getWidth()/2, push:getHeight()/2)
	self.name = "Player"
	self.isPlayer = true

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = 4, y = 4 }
	local g = anim8.newGrid(8, 8, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-3',1), 0.1)

	return self
end

function Player:update(dt)
end

return Player