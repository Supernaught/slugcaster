io.stdout:setvbuf("no")

-- Global libraries
PaletteSwitcher = require('lib/PaletteSwitcher');
class = require "lib.30log"
tiny = require "lib.tiny"
editgrid = require "lib.editgrid"
Gamestate = require "lib.hump.gamestate"
Object = require "lib.classic"
timer = require "lib.hump.timer"
anim8 = require "lib.anim8"
gamera = require "lib.gamera"

-- Ulydev camera options
Camera = require "lib.hump.camera"
screen = require "lib.shack"
push = require "lib.push"

-- utils
log = require "lib.log"
tlog = require "lib.alfonzm.tlog"
escquit = require "lib.alfonzm.escquit"

-- States
PlayState = require "playstate"
DemoState = require "demostate"
MenuState = require "menustate"

local assets =  require "src.assets"

-- Declare tiny-ecs world
world = {}
camera = nil

-- Game stuff
local scale = 1

function love.load()
	_G.TILE_SIZE = 8
	scale = love.graphics.getWidth() / 160
	setupPushScreen()
	camera = Camera(0,0)
	PaletteSwitcher.init('lib/palettes_v4.png', 'lib/palette.fs');
    PaletteSwitcher.prev()

	Gamestate.registerEvents()
	Gamestate.switch(MenuState)
	-- Gamestate.switch(DemoState)

    -- bg music
	assets.music1:setVolume(0.8)
	assets.music1:setLooping(true)
	assets.music1:play()
	assets.explode3_sfx:setVolume(0.8)
end

function love.update(dt)
	screen:update(dt)
	timer.update(dt)
end

function love.draw()
    PaletteSwitcher.set();

	love.graphics.setBackgroundColor(32.0/255.0, 70.0/255.0, 49.0/255.0, 1)
	-- camera:attach()
	push:apply("start")
	screen:apply()

	if world and world.update then
		world:update(love.timer.getDelta())
	end
	push:apply("end")

	-- camera:detach()
	PaletteSwitcher.unset()

end

function love.keypressed(k)
	if k == '1' then
		PaletteSwitcher.prev()
	elseif k == '2' then
		PaletteSwitcher.next()
	end
end

function setupPushScreen()
	-- setup push screen
	local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
	local gameWidth, gameHeight = windowWidth / scale, windowHeight / scale
	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})
	screen:setDimensions(push:getDimensions())
end

function switchPalette()
	PaletteSwitcher.next()
	timer.after(0.8, function() switchPalette() end)
end