menu = {}

function menu:init()
	love.graphics.setBackgroundColor(255,255,255)

end

function menu:enter()


end

function menu:update(dt)


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
				Gamestate.switch(game)

			end 
		end
	end  
end 

function menu:joystickpressed()


end 