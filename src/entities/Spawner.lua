--
-- Spawner
-- by Alphonsus
--
-- spawn enemies randomly
--

local Spawner = Object:extend()
local vector = require "lib.hump.vector"
local lume = require "lib.lume"
local Enemy = require "src.entities.Enemy"
local EnemyWalker = require "src.entities.EnemyWalker"
local EnemyRandomWalker = require "src.entities.EnemyRandomWalker"

function Spawner:new()
	self.name = "Spawner"
	self.isSpawner = true
	self:spawn()

	return self
end

function Spawner:update(dt)
end

function Spawner:spawn()
	world:add(lume.randomchoice({
		EnemyWalker(),
		EnemyRandomWalker()
	}))
	timer.after(math.random(0.1,1.5), function() self:spawn() end)
end

return Spawner