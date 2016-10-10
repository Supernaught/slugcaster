--
-- EnemyBullet
--
-- requires MoveTowardsAngle system
--

local EnemyBullet = GameObject:extend()
local assets =  require "src.assets"
local vector = require "lib.hump.vector"
local lume = require "lib.lume"

function EnemyBullet:new(x, y, angle, speed)
	EnemyBullet.super.new(self, x, y)

	-- entity
	self.name = "EnemyBullet"
	self.isEnemyBullet = true

	self.angle = angle or self.angle

	-- EnemyBullet sprite
	self.sprite = assets.enemy_bullet
	self.offset = { x = 6, y = 6 }
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-4',1), 0.1)

	-- MoveTowardsAngle component
	self.moveTowardsAngle = true

	-- movable component
	self.speed = speed or 40
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

	-- self.angle = self.angle + lume.random(-0.1,0.1)

	local playerPos = {
		x = playstate.getPlayer().pos.x,
		y = playstate.getPlayer().pos.y,
	}

	self.angle = math.atan2((playerPos.y - self.pos.y), (playerPos.x - self.pos.x)) + math.rad(90)

	-- self.moveTowardsTarget = true
	-- self.targetPos = {x=0,y=0}
	-- self.targetPos.x = playstate.getPlayer().pos.x
	-- self.targetPos.y = playstate.getPlayer().pos.y

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y + self.offset.y, 6, 6)
	self.collider:moveTo(self.pos.x, self.pos.y)
	self.collider['parent'] = self

	-- destroy if out of screen
	self.destroyOffScreen = true

	return self
end

function EnemyBullet:onCollision(other, delta)
end

function EnemyBullet:die()
	self.toRemove = true
end

function EnemyBullet:update(dt)
end

return EnemyBullet
