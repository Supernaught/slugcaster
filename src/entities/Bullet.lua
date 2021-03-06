--
-- Bullet
--
-- requires MoveTowardsAngle system
--

local Bullet = GameObject:extend()
local assets =  require "src.assets"
local WaterSplash =  require "src.entities.WaterSplash"
local vector = require "lib.hump.vector"
local lume = require "lib.lume"

function Bullet:new(x, y, angle, speed)
	Bullet.super.new(self, x, y)

	-- entity
	self.name = "Bullet"
	self.isBullet = true

	self.angle = angle or self.angle

	-- Bullet
	self.sprite = assets.bullet
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }
	self.touchedWater = (self.pos.y >= 120 - 12)

	-- MoveTowardsAngle component
	self.moveTowardsAngle = true

	-- movable component
	self.speed = speed or 200
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 },
		maxVelocity = { x = 0, y = 0 },
	}

	-- rotatable component
	self.rotatable = {
		speed = 10,
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 12
	}

	-- randomize a bit
	-- self.pos.x = self.pos.x + lume.random(5,10)
	-- self.pos.y = self.pos.y + lume.random(5,10)
	self.angle = self.angle + lume.random(-0.1,0.1)

	-- add small padding in front of player
	self.pos.x = self.pos.x + (self.pos.x * math.cos(self.angle - math.rad(90)) * 0.12)
	self.pos.y = self.pos.y + (self.pos.y * math.sin(self.angle - math.rad(90)) * 0.12)

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y + self.offset.y, self.sprite:getWidth() / 1.4, self.sprite:getHeight())
	self.collider:moveTo(self.pos.x, self.pos.y)
	self.collider['parent'] = self

	-- destroy if out of screen
	self.destroyOffScreen = true

	return self
end

function Bullet:onCollision(other, delta)
	if other.isAlive and other.isEnemy then
		self:die()
	end
	-- other.die()
	-- other:onCollision(self, delta)
	-- self.isAlive = false
end

function Bullet:die()
	self.toRemove = true
end

function Bullet:update(dt)
	if self.pos.y >= 120 - 12 and not self.touchedWater then
		world:add(WaterSplash(self.pos.x - self.offset.x, 120-10))
		self.touchedWater = true
	end
end

return Bullet
