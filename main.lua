io.stdout:setvbuf("no")
local Object = require "lib.classic"
local World = require "alph.World"

local world

function love.load()
	world = World()
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	world:update(dt)
end