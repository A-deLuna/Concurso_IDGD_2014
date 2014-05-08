menu = {}

function menu:init()
	music = love.audio.newSource("sound/music.mp3")
	music:setVolume(0.3)
	love.graphics.setBackgroundColor(255,255,255)

end

function menu:enter()
	love.graphics.setBackgroundColor(255,255,255)


end

function menu:update(dt)
music:play()

end

function menu:draw()
	love.graphics.setColor(230,0,255)
	love.graphics.rectangle("fill", 350, 250, 100, 100)

end 

function menu:keypressed()


end 

function menu:mousepressed(x, y, button)
	if button == "l" then 
		if x >= 350 and x <= 450 then 
			if y >= 250 and y <= 350 then 
				music:stop()
				Gamestate.switch(game)

			end 
		end
	end  
end 

function menu:joystickpressed()


end 