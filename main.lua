io.stdout:setvbuf("no")

-- Global libraries
class = require "lib.30log"
tiny = require "lib.tiny"
editgrid = require "lib.editgrid"
Gamestate = require "lib.hump.gamestate"
Object = require "lib.classic"
timer = require "lib.hump.timer"
anim8 = require "lib.anim8"

-- Ulydev camera options
screen = require "lib.shack"
push = require "lib.push"

-- utils
log = require "lib.log"
tlog = require "lib.alfonzm.tlog"
escquit = require "lib.alfonzm.escquit"

-- States
local PlayState = require "playstate"
local MenuState = require "menustate"

local assets =  require "src.assets"

-- Declare tiny-ecs world
world = {}
camera = nil

-- Game settings
local scale = 1

function love.load()
	_G.TILE_SIZE = 8
	scale = love.graphics.getWidth() / 160
	setupPushScreen()
	Gamestate.registerEvents()
	-- Gamestate.switch(MenuState)
	Gamestate.switch(PlayState)
end

function love.update(dt)
	screen:update(dt)
	timer.update(dt)
end

function love.draw()
	push:apply("start")
	screen:apply()
	
	if world and world.update then
		world:update(love.timer.getDelta())
	end

	push:apply("end")
end

function setupPushScreen()
	-- setup push screen
	local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
	local gameWidth, gameHeight = windowWidth / scale, windowHeight / scale
	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})
	screen:setDimensions(push:getDimensions())
end