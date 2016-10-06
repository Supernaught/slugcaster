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

	-- TODO: change assets here

	-- sprite/animation component
	-- self.sprite = assets.enemy
	-- self.offset = { x = 4, y = 4 }
	-- local g = anim8.newGrid(_G.TILE_SIZE, _G.TILE_SIZE, self.sprite:getWidth(), self.sprite:getHeight())
	-- self.animation = anim8.newAnimation(g('1-3',1), 0.1)

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
