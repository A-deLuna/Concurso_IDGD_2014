gameOver = {}


function gameOver:init()
	gameOverIdent=love.audio.newSource("sound/gameOverIdent.mp3")
	love.graphics.setBackgroundColor(255,255,0)

end

function gameOver:enter()
	gameOverIdent:play()
	Highscores.check()

end

function gameOver:update(dt)


end

function gameOver:draw()
	love.graphics.setColor(230,0,255)

	--local n = 1
	--for lines in io.lines("Highscores.txt") do 
	--	love.graphics.print(lines,100, n * 50)
	--	n = n + 1 
	--end 

	local f = io.open("Highscores.txt", "r")
	local l = f:read("*all")
	l = string.gsub(l, " ", "\n")
	love.graphics.print(l, 300, 300)
	io.close(f)

	love.graphics.print("click izquierdo para continuar", 100, 200)
	Highscores.print() 
end 

function gameOver:keypressed()


end 

function gameOver:mousepressed(x, y, button)
	if button == "l" then 
		Gamestate.switch(menu)

	end  
end 

function gameOver:joystickpressed()


end 