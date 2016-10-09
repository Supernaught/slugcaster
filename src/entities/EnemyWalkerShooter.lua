GameObject = require "src.entities.GameObject"
Explosion = require "src.entities.Explosion"
Enemy = require "src.entities.Enemy"
lume = require "lib.lume"

local EnemyWalkerShooter = Enemy:extend()
local assets =  require "src.assets"
local EnemyBullet = require "src.entities.EnemyBullet"

function EnemyWalkerShooter:new()
	EnemyWalkerShooter.super.new(self, 0, 0)
	self.name = "EnemyWalkerShooter"
	self.isEnemyWalkerShooter = true

	-- hp
	self.hp = 5

	-- sprite/animation component
	self.sprite = assets.brood_jellyfish
	self.offset = { x = 12, y = 12 }
	local g = anim8.newGrid(24, 24, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-6',1), 0.1)
	self.spark = false

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, 18, 18)
	self.collider['parent'] = self

	self:setupBehavior()

	timer.after(1, function() self:shootEnemyBullet() end)

	if self.movable.velocity.x < 0 then
		self.flippedH = false
	else
		self.flippedH = true
	end

	return self
end

function EnemyWalkerShooter:setupBehavior()
	spawnOnSide = lume.randomchoice({0,1})
	spawnPos = {x = 0, y = 0}

	local xVel, yVel = 0, 0

	local mainSpeed = math.random(10,10)
	local randomSpeed = 3

	if spawnOnSide == 0 then
		spawnPos.x = lume.randomchoice({0,push:getWidth()})
		spawnPos.y = math.random(0,push:getHeight())
		if spawnPos.x == 0 then
			xVel = mainSpeed
		else
			xVel = -mainSpeed
		end

		yVel = math.random(-randomSpeed,randomSpeed)
	else
		spawnPos.x = math.random(0,push:getWidth())
		spawnPos.y = lume.randomchoice({0,push:getHeight()})
		if spawnPos.y == 0 then
			yVel = mainSpeed
		else
			yVel = -mainSpeed
		end
		xVel = math.random(-randomSpeed,randomSpeed)
	end

	self.pos.x = spawnPos.x
	self.pos.y = spawnPos.y

	self.movable.velocity.x = xVel
	self.movable.velocity.y = yVel
end

function EnemyWalkerShooter:shootEnemyBullet()
	if self.isAlive then
		local enemyBullet = EnemyBullet(self.pos.x, self.pos.y)
		enemyBullet.angle = enemyBullet.angle + math.rad(lume.random(-10,10))

		world:add(enemyBullet)
		timer.after(math.random(3,6), function() self:shootEnemyBullet() end)
	end
end

function EnemyWalkerShooter:update(dt)
	EnemyWalkerShooter.super.update(self, dt)
	if self.movable.velocity.x < 0 then
		self.flippedH = false
	else
		self.flippedH = true
	end
end

function EnemyWalkerShooter:die()
	EnemyWalkerShooter.super.die(self)

	-- other enemy walker specific stuff here
end

return EnemyWalkerShooter
