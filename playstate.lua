--
-- playstate
--

local play = {}

-- Entity/World management
local Object = require "lib.classic"
local World = require "alph.World"
local world

function play:init()
	world = World()
end

function play:enter()
end

function play:update(dt)
	world:update(dt)
end

function play:draw()
	world:update(dt)

	love.graphics.print("PLAY", 50, 50)
end

return play