gameOver = {}


function gameOver:init()
	gameOverIdent=love.audio.newSource("sound/gameOverIdent.mp3")
end

function gameOver:enter()
	gameOverIdent:play()
	Highscores.check()

end

function gameOver:update(dt)


end

function gameOver:draw()
	local font = love.graphics.newFont(40)
	love.graphics.clear()
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setFont(font)
	love.graphics.setColor(255,255,255)

	--local n = 1
	--for lines in io.lines("Highscores.txt") do 
	--	love.graphics.print(lines,100, n * 50)
	--	n = n + 1 
	--end 

	local f = io.open("Highscores.txt", "r")
	local l = f:read("*all")
	l = string.gsub(l, " ", "\n")
	love.graphics.print(l, 330, 200)
	io.close(f)
	love.graphics.print("Puntajes mas altos", 200, 100)

	Highscores.print() 
end 

function gameOver:keypressed()
	Gamestate.switch(menu)
end 

function gameOver:mousepressed(x, y, button)
	Gamestate.switch(menu)
end 

function gameOver:joystickpressed()
	Gamestate.switch(menu)
end 