local lume = require "lib.lume"

GameObject = require "src.entities.GameObject"
Explosion = require "src.entities.Explosion"

local Enemy = GameObject:extend()
local assets =  require "src.assets"

function Enemy:new(x, y, xVel, yVel)
	Enemy.super.new(self, x, y)
	self.name = "Enemy"
	self.isEnemy = true

	-- hp
	self.hp = 1

	-- sprite/animation component
	self.sprite = assets.enemy
	self.offset = { x = 4, y = 4 }
	self.flippedH = false
	local g = anim8.newGrid(_G.TILE_SIZE, _G.TILE_SIZE, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-3',1), 0.1)

	-- movable component
	self.movable = {
		velocity = { x = xVel or 0, y = yVel or 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 0, y = 0 }, -- 80 = gravity
		maxVelocity = { x = 80, y = 100 },
		speed = { x = 0, y = 0 } -- used to assign to acceleration
	}

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, _G.TILE_SIZE, _G.TILE_SIZE)
	self.collider['parent'] = self

	-- destroy off screen
	self.destroyOffScreen = true

	-- particles
	self.hitPs = love.graphics.newParticleSystem(assets.smoke, 100)
	self.hitPs:setPosition(push:getWidth()/2, push:getHeight()/2)
	self.hitPs:setParticleLifetime(0.2, 0.5)
	self.hitPs:setDirection(1.5*3.14)
	self.hitPs:setSpread(3.14/3)
	self.hitPs:setSpeed(100, 150)
	self.hitPs:setSizes(0.2, 0)
	self.hitPs:setLinearAcceleration(0, 600)
	self.hitPs:setLinearDamping(0.3)
	self.hitPs:setSpin(3, 5)
	self.hitPs:setRotation(0, 2*3.14)
	self.hitPs:setInsertMode('random')

	return self
end

function Enemy:update(dt)
    self.hitPs:update(dt)
	self:updateAnimations()
end

function Enemy:onCollision(other)
	if other.isBullet and self.isAlive and other.isAlive then
		self:hit()
	end
end

function Enemy:hit(damage)
	self.hp = self.hp - (damage or 1)

	if self.isAlive and not self.toRemove and self.hp <= 0 then
		-- die
		self:die()
	else
		-- take damage
		self.spark = true
		
		self.hitPs:setPosition(self.pos.x, self.pos.y)
		self.hitPs:emit(math.random(2,5))
		hit1_sfx = assets.bullet_sfx:clone()
		hit1_sfx:play()
		screen:setShake(4)
	end
end

function Enemy:die()
	self.toRemove = true

	smokePs:setPosition(self.pos.x, self.pos.y)
	smokePs:emit(math.random(1,3))

	-- add 5 explosions
	love.graphics.setColor(215, 232, 148)
	love.graphics.setLineStyle('rough')
	love.graphics.circle("fill", self.pos.x, self.pos.y, 15, 100 )

	for i=5,1,-1
	do
		timer.after((lume.random(0, .2)), function()
			world:add(Explosion(self.pos.x + lume.random(-10, 10), self.pos.y + lume.random(-10, 10)))
		end)
	end

	explode_sfx = lume.randomchoice({
		assets.explode1_sfx:clone(),
		-- assets.explode2_sfx:clone(),
		assets.explode3_sfx:clone(),
	})
	explode_sfx:play()

	screen:setShake(12)
	screen:setRotation(0.05)

	playstate.addScore()
end

function Enemy:draw()
	love.graphics.draw(self.hitPs, 0, 0, 0, 1, 1)
end

function Enemy:updateAnimations()
	if self.movable.velocity.x < 0 then
		self.flippedH = false
	elseif self.movable.velocity.x > 0 then
		self.flippedH = true
	end
end

return Enemy
