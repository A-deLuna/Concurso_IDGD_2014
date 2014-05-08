intro={}
intro.framecount=0
intro.cheve={}

function intro.load()
	intro.framecount=0.00000000001
	for i=0,119,1 do
		if i >99 then
			intro.cheve[i+1]=love.graphics.newImage("img/intro/Sequence 01"..tostring(i)..".jpg")
		elseif i==0 then
			intro.cheve[i+1]=love.graphics.newImage("img/intro/Sequence 0100"..tostring(i)..".jpg")
		elseif i<10 then
			intro.cheve[i+1]=love.graphics.newImage("img/intro/Sequence 0100"..tostring(i)..".jpg")
		elseif i<100 then
			intro.cheve[i+1]=love.graphics.newImage("img/intro/Sequence 010"..tostring(i)..".jpg")
		end
	end
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
		Gamestate.switch(menu)
	else
		intro.framecount=intro.framecount+150*dt
	end
end

function intro:draw()
	frame = math.ceil(intro.framecount/5)
	love.graphics.draw(intro.cheve[frame],0,0)
end 

function intro:keypressed()


end 

function intro:mousepressed(x, y, button)
	

end 

function intro:joystickpressed()


end 

