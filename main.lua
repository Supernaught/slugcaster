io.stdout:setvbuf("no")
-- Game States
Gamestate = require "lib.hump.gamestate"
playstate = require "playstate"
menustate = require "menustate"

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(menustate)
end

function love.update(dt)
end

function love.draw()
end