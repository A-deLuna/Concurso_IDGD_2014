intro={}
intro.framecount=0

function intro.load()
	intro.framecount=0.00000000001
	for i=0,119,1 do 
		cheve[i+1]=love.graphics.newImage("img/intro/Sequence 01"..tostring(i)..".jpg")
	end
end

function intro.update(dt)
	if intro.framecount>600 then
		Gamestate.switch(menu)
	else
		intro.framecount=5*dt
	end
end

function intro.draw()
	frame = math.ceil(intro.framecount/5)-1
	love.graphics.draw(cheve[frame],0,0)
end

function intro:init()
	intro.load()
end

function intro:enter()
	intro.load()
end

function intro:update(dt)
	intro.update(dt)
end

function intro:draw()
	intro.draw()
end 

function intro:keypressed()


end 

function intro:mousepressed(x, y, button)
	

end 

function intro:joystickpressed()


end 

