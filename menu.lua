menu = {}

function menu:init()
	music = love.audio.newSource("sound/music.mp3")
	music:setVolume(0.3)
	tituloComienzo=love.graphics.newImage("img/littlegirl.png")
	comienzo=newAnimation(tituloComienzo, 400,200,0.4,0)
	comienzo:setMode("once")
	tituloMedio=love.graphics.newImage("img/PRESIDENT.png")
	mitad=newAnimation(tituloMedio, 400,200,0.1,0)
	mitad:setMode("once")
	love.graphics.setColor(255,255,255)
	tituloFinal=love.graphics.newImage("img/title.png")
	final=newAnimation(tituloFinal, 400,200,0.2,0)

end

function menu:enter()



end

function menu:update(dt)
comienzo:update(dt)
if comienzo:getCurrentFrame()==comienzo:getSize() then
mitad:update(dt)
end
if mitad:getCurrentFrame()==mitad:getSize() then
final:update(dt)
	if music:isStopped() then
		music:play()
	end
end

gamepad.update()
if gamepad.isDown[2] then
	Gamestate.switch(game)
end
end

function menu:draw()
comienzo:draw(200,150)
if comienzo:getCurrentFrame()==comienzo:getSize() then
mitad:draw(200,150)
end
if mitad:getCurrentFrame()==mitad:getSize() then
final:draw(200,150)
end
love.graphics.setFont(love.graphics.newFont(15))
love.graphics.print("Press Enter/Click anywhere on the screen",230,500)

end 

function menu:keypressed()
if key == "enter" then
		music:stop()
		Gamestate.switch(game)
	end

end 

function menu:mousepressed(x, y, button)
	if button == "l" then 
				music:stop()
				Gamestate.switch(game)
	end  
end 

function menu:joystickpressed()
	music:stop()
	Gamestate.switch(game)
end
