GameObject = require "src.entities.GameObject"
Bullet = require "src.entities.Bullet"

local Player = GameObject:extend()
local assets =  require "src.assets"

local gravity = 100 * 2
local flySpeed = 150 * 2
local leftRightSpeed = 800
local xDrag = 300

function Player:new()
	Player.super.new(self, push:getWidth()/2, push:getHeight()/2)
	self.name = "Player"
	self.isPlayer = true

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = 4, y = 4 }
	self.flippedH = false
	local g = anim8.newGrid(_G.TILE_SIZE, _G.TILE_SIZE, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-3',1), 1, false)

	-- movable component
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = xDrag, y = -gravity }, -- 80 = gravity
		maxVelocity = { x = 80, y = 60 },
		speed = { x = 0, y = 0 } -- used to assign to acceleration
	}

	-- shooter component
	self.shooter = {
		atkDelay = 0.1,
		canAtk = true,
		shoot = false
	}
	self.shootAngle = 0

	setupParticles()

	return self
end

function Player:update(dt)
	shootControls(self,dt)
	-- moveControls(self, dt)
	updateAnimations(self)

    bulletPs:update(dt)
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
	local down = love.keyboard.isDown('down')
	local up = love.keyboard.isDown('up')
	local left = love.keyboard.isDown('left')
	local right = love.keyboard.isDown('right')

	self.shooter.shootUp = false
	self.shooter.shootDown = false
	self.shooter.shootLeft = false
	self.shooter.shootRight = false

	if up then
		self.movable.acceleration.y = flySpeed
	elseif down then
		self.movable.acceleration.y = -flySpeed
	else
		self.movable.acceleration.y = 0
	end

	if left then
		self.movable.acceleration.x = flySpeed
	elseif right then
		self.movable.acceleration.x = -flySpeed
	else
		self.movable.acceleration.x = 0
	end

	if left or up or down or right then
		self.shooter.shoot = true
	end

	if left then
		self.shootAngle = -90

		if up then self.shootAngle = self.shootAngle + 45
		elseif down then
			self.shootAngle = self.shootAngle - 45
		end
	elseif right then
		self.shootAngle = 90

		if up then
			self.shootAngle = self.shootAngle - 45
		elseif down then
			self.shootAngle = self.shootAngle + 45
		end
	elseif up then
		self.shootAngle = 0
	elseif down then
		self.shootAngle = 180
	end
end

function setupParticles()
	bulletPs = love.graphics.newParticleSystem(assets.shells, 100)
    -- bulletPs:setEmissionRate(400)
	bulletPs:setPosition(push:getWidth()/2, push:getHeight()/2)
	bulletPs:setParticleLifetime(0.5, 2)
    -- bulletPs:setSizeVariation(0.5)
    bulletPs:setDirection(1.5*3.14)
    bulletPs:setSpread(3.14/1.5)
    bulletPs:setSpeed(50, 100)
    bulletPs:setLinearAcceleration(0, 120)
    bulletPs:setLinearDamping(0.8)
    bulletPs:setSpin(0, 3)
    bulletPs:setRotation(0, 2*3.14)
    bulletPs:setInsertMode('random')
end

function Player:shoot(dt)
	bulletPs:setPosition(self.pos.x, self.pos.y)
	bulletPs:emit(1)
	world:addEntity(Bullet(self.pos.x, self.pos.y, math.rad(self.shootAngle)))
end

function Player:draw()
    love.graphics.draw(bulletPs, 0, 0, 0, 1, 1)
end

function updateAnimations(self)
	if self.movable.acceleration.x < 0 then
		self.flippedH = true
	elseif self.movable.acceleration.x > 0 then
		self.flippedH = false
	end
end

return Player