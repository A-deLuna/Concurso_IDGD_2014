intro={}
intro.framecount=0
intro.cheve=nil

function intro.load()
	intro.cheve=love.graphics.newImage("img/intro/Sequence 01100.jpg")
end

function intro.update(dt)

end

function intro.draw()

end

function intro:init()
	intro.load()
end

function intro:enter()
	intro.load()
end

function intro:update(dt)
	if intro.framecount>590 then
		intro.cheve=nil
		Gamestate.switch(menu)
	else
		intro.framecount=intro.framecount+150*dt
	end
end

function intro:draw()
	love.graphics.draw(intro.cheve,0,0)
end 

function intro:keypressed()


end 

function intro:mousepressed(x, y, button)
	

end 

function intro:joystickpressed()


end 

