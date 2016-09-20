io.stdout:setvbuf("no")

-- Global libraries
class = require "lib.30log"
tiny = require "lib.tiny"
Gamestate = require "lib.hump.gamestate"
editgrid = require "lib.editgrid"
Object = require "lib.classic"

-- States
local PlayState = require "playstate"
local MenuState = require "menustate"

-- Declare tiny-ecs world
world = {}
camera = nil

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(MenuState)
end

function love.update(dt)
end

function love.draw()
	if camera then camera:attach() end
	
	if world and world.update then
		world:update(love.timer.getDelta())
	end

	if camera then camera:detach() end
end