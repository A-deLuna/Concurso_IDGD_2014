gameOver = {}


function gameOver:init()
	love.graphics.setBackgroundColor(255,255,0)

end

function gameOver:enter()
	Highscores.check()

end

function gameOver:update(dt)


end

function gameOver:draw()
	love.graphics.setColor(230,0,255)
	local n = 1
	for lines in io.lines("Highscores.txt") do 
		love.graphics.print(lines,100, n * 50)
		n = n + 1 
	end 
	love.graphics.print("click izquierdo para continuar", 100, 200)
	Highscores.print() 
end 

function gameOver:keypressed()


end 

function gameOver:mousepressed(x, y, button)
	if button == "l" then 
		Gamestate.switch(game)

	end  
end 

function gameOver:joystickpressed()


end 