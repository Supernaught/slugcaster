function love.keypressed(k)
	if k == 'escape' then
		love.event.push('quit')
	end
end