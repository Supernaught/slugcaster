GameObject = require "src.entities.GameObject"
Explosion = require "src.entities.Explosion"
Enemy = require "src.entities.Enemy"
lume = require "lib.lume"

local EnemyWalker = Enemy:extend()
local assets =  require "src.assets"

function EnemyWalker:new()
	EnemyWalker.super.new(self, 0, 0)
	self.name = "EnemyWalker"
	self.isEnemyWalker = true


	-- TODO: change assets here
	self.setupParticles()

	-- sprite/animation component
	self.sprite = assets.skull
	self.offset = { x = 4, y = 4 }
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-4',1), 0.1)

	self:setupBehavior()

	return self
end

function EnemyWalker:setupBehavior()
	spawnOnSide = lume.randomchoice({0,1})
	spawnPos = {x = 0, y = 0}

	local xVel, yVel = 0, 0

	local mainSpeed = math.random(50,70)
	local randomSpeed = 10

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

function EnemyWalker:update(dt)
		skullSmoke:update(dt)
		skullSmoke:setPosition(self.pos.x + math.random(-2,2), self.pos.y + 12)
		skullSmoke:emit(1)
end

function EnemyWalker:setupParticles()
	skullSmoke = love.graphics.newParticleSystem(assets.smoke, 100)
	skullSmoke:setPosition(push:getWidth()/2, push:getHeight()/2)
	skullSmoke:setParticleLifetime(0.2, 0.4)
  skullSmoke:setDirection(1.5*3.14)
  skullSmoke:setSpread(3.14/3)
  skullSmoke:setLinearAcceleration(0, -400)
  skullSmoke:setLinearDamping(50)
  skullSmoke:setSpin(0, 30)
	skullSmoke:setColors(82, 127, 57, 255)
  skullSmoke:setRotation(0, 2*3.14)
  skullSmoke:setInsertMode('random')
	skullSmoke:setSizes(math.random(0.5, 0.8), 0)
end

function EnemyWalker:die()
	EnemyWalker.super.die(self)

	-- other enemy walker specific stuff here
end

return EnemyWalker
