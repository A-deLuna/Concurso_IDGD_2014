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

	else

		intro.framecount=5*dt
	end
end

function intro.draw()
	frame = math.ceil(intro.framecount/5)-1
	love.graphics.draw(cheve[frame],0,0)
end