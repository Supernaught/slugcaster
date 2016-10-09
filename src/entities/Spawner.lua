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
local EnemyWalkerShooter = require "src.entities.EnemyWalkerShooter"

local level = 1
local spawnDelayMin, spawnDelayMax

function Spawner:new()
	self.name = "Spawner"
	self.isSpawner = true

	self:spawn()

	spawnDelayMin = 0.2
	spawnDelayMax = 1

	return self
end

function Spawner:update(dt)
end

function Spawner:spawn()
	world:add(lume.randomchoice({
		EnemyWalker(),
		EnemyRandomWalker(),
		-- EnemyWalkerShooter(),
	}))
	timer.after(lume.random(spawnDelayMin,spawnDelayMax), function() self:spawn() end)
end

return Spawner