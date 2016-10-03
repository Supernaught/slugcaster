--
-- Spawner
-- by Alphonsus
--
-- spawn enemies randomly on screen borders
--

local Spawner = Object:extend()
local vector = require "lib.hump.vector"
local lume = require "lib.lume"
local timer = require "lib.hump.timer"
local Enemy = require "src.entities.Enemy"

function Spawner:new()
	self.name = "Spawner"
	self.isSpawner = true
	self:spawn()
	return self
end

function Spawner:update(dt)
	timer.update(dt)
end

function Spawner:spawn()
	spawnOnSide = lume.randomchoice({0,1})
	spawnPos = {x = 0, y = 0}

	local xVel, yVel = 0, 0

	local mainSpeed = math.random(40,70)
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

	world:add(Enemy(spawnPos.x, spawnPos.y, xVel, yVel))
	timer.after(math.random(1,5), function() self:spawn() end)
end

return Spawner