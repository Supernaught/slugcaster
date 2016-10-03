GameObject = require "src.entities.GameObject"

local Player = GameObject:extend()
local assets =  require "src.assets"

local gravity = 300
local flySpeed = 450
local leftRightSpeed = 800
local xDrag = 600

function Player:new()
	Player.super.new(self, push:getWidth()/2, push:getHeight()/2)
	self.name = "Player"
	self.isPlayer = true

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = 4, y = 4 }
	local g = anim8.newGrid(8, 8, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-3',1), 0.1)

	-- movable component
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = xDrag, y = -gravity }, -- 80 = gravity
		maxVelocity = { x = 80, y = 100 },
		speed = { x = 0, y = 0 } -- used to assign to acceleration
	}

	-- shooter component
	self.shooter = {
		atkDelay = 0.08,
		canAtk = true,
		shoot = false
	}


	return self
end

function Player:update(dt)
	shootControls(self,dt)
	moveControls(self, dt)
end

function moveControls(self, dt)
	local z = love.keyboard.isDown('z')
	local left = love.keyboard.isDown('left')
	local right = love.keyboard.isDown('right')

	if z then
		self.movable.acceleration.y = -flySpeed
		-- self.movable.velocity.y = self.movable.maxVelocity.y
	else
		self.movable.acceleration.y = 0
	end

	if left and not right then
		self.movable.acceleration.x = -leftRightSpeed
	elseif right and not left then
		self.movable.acceleration.x = leftRightSpeed
	else 
		self.movable.acceleration.x = 0
	end
end

function shootControls(self,dt)
	local z = love.keyboard.isDown('z')

	if z then
		self.shooter.shoot = true
	end
end

return Player