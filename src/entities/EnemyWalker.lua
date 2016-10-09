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

	self:setupParticles()

	-- TODO: change assets here

	-- sprite/animation component
	self.sprite = assets.skull
	self.offset = { x = 6, y = 6 }
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-4',1), 0.1)

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, 8, 8)
	self.collider['parent'] = self

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

	if xVel < 0 then
		self.flippedH = true
	end

end

function EnemyWalker:update(dt)
	self.skullTrailPs:update(dt)
	self.skullTrailPs:setPosition(self.pos.x - (0.1*self.movable.velocity.x)/1.5, self.pos.y - (0.1*self.movable.velocity.y)/1.5)
	self.skullTrailPs:emit(1)
end

function EnemyWalker:setupParticles()
	self.skullTrailPs = love.graphics.newParticleSystem(assets.smoke, 100)
	self.skullTrailPs:setPosition(push:getWidth()/2, push:getHeight()/2)
	self.skullTrailPs:setParticleLifetime(0.2, 0.4)
	self.skullTrailPs:setDirection(1.5*3.14)
	self.skullTrailPs:setSpread(3.14/3)
	self.skullTrailPs:setLinearAcceleration(0, -400)
	self.skullTrailPs:setLinearDamping(50)
	self.skullTrailPs:setSpin(0, 30)
	self.skullTrailPs:setColors(82, 127, 57, 255)
	self.skullTrailPs:setRotation(0, 2*3.14)
	self.skullTrailPs:setInsertMode('random')
	self.skullTrailPs:setSizes(0.4, 0)
end

function EnemyWalker:draw()
    love.graphics.draw(self.skullTrailPs, 0, 0, 0, 1, 1)
end

function EnemyWalker:die()
	EnemyWalker.super.die(self)

	-- other enemy walker specific stuff here
end

return EnemyWalker
