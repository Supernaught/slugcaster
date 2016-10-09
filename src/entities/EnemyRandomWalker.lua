local lume = require "lib.lume"

GameObject = require "src.entities.GameObject"
Explosion = require "src.entities.Explosion"
Enemy = require "src.entities.Enemy"

local EnemyRandomWalker = Enemy:extend()
local assets =  require "src.assets"

function EnemyRandomWalker:new()
	EnemyRandomWalker.super.new(self, 0, 0)
	self.name = "EnemyRandomWalker"
	self.isEnemyRandomWalker = true

	self.hp = 2

	-- TODO: change assets here

	-- sprite/animation component
	self.sprite = assets.jellyfish
	self.offset = { x = 8, y = 8 }
	local g = anim8.newGrid(12, 12, self.sprite:getWidth(), self.sprite:getHeight())
	self.animation = anim8.newAnimation(g('1-5',1), 0.1)

	-- collider
	self.collider = HC:rectangle(self.pos.x - self.offset.x, self.pos.y - self.offset.y, 12, 12)
	self.collider['parent'] = self

	-- move towards target component
	self.moveTowardsTarget = true
	self.moveTargetSpeed = 20
	self.targetPos = {x = 160/2, y = 144/2}

	self:setupBehavior()

	return self
end

function EnemyRandomWalker:setupBehavior()
	spawnOnSide = lume.randomchoice({0,1})

	if spawnOnSide == 0 then
		self.pos.x = lume.randomchoice({0,push:getWidth()})
		self.pos.y = math.random(0,push:getHeight())
	else
		self.pos.x = math.random(0,push:getWidth())
		self.pos.y = lume.randomchoice({0,push:getHeight()})
	end
end

function EnemyRandomWalker:update(dt)
	EnemyRandomWalker.super.update(self, dt)

	if self.isInTargetPos then
		self.targetPos.x = lume.random(0,push:getWidth())
		self.targetPos.y = lume.random(0,push:getHeight())
	end
end

function EnemyRandomWalker:die()
	EnemyRandomWalker.super.die(self)
	-- other enemy walker specific stuff here
end

return EnemyRandomWalker
