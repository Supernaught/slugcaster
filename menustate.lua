--
-- menustate
--

local menu = {}

function menu:enter()
end

function menu:update(dt)
end

function menu:keyreleased(key, code)
	if key == 'return' then
		Gamestate.switch(playstate)
	elseif key == 'escape' then
		love.event.push('quit')
	end
end

function menu:draw()
	love.graphics.print("MAIN MENU\n\nPress ENTER to start.\nPress ESC to quit", 50, 50)
end

return menu