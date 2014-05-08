map  = {}
function map.load()
	map.type = 0 

	map.pain = 1
	map.woods = 2
	map.boss = 3
	map.doorHeight1 = 240
	map.doorHeight2 = 360
	map.doorWidth1 = 370
	map.doorWidth2 = 430
	map.timeForNextLevel = 60
	map.positionX = 0
	map.positionY = 0
	map.imageNumber= 0
	map.background = love.graphics.newImage('img/fondo.png')
	map.isUpdated = false
	map.isSlowed = false
	map.spikes = love.graphics.newImage("img/spikes.png")
	map.mud = love.graphics.newImage('img/mud.png')
end
function map.newMapTransition()

	if player.y + player.height < 0 then 

		table.remove(powerup)
		map.loadMap()
		
		player.y = screenHeight + player.height - 90
		

		
		
		Timer.add(2, function () map.timeForNextLevel = map.timeForNextLevel + 55 end)
		enemy.stopGenerate = false
	end 
	

end  

function map.update()
	
	
		map.newMapTransition()
	if not map.isUpdated then 
		map.loadMap()
	end 
 
end 

function map.loadMap()
	map.imageNumber = map.imageNumber + 1 

	map.isUpdated = true
end 

function MAP_UPDATE(dt)
	map.playerBounds()
end 
function map.playerBounds()
	if   enemy.stopGenerate then 
		if  player.x < 90 then
			player.x = 90
		elseif player.x  + player.width > screenWidth-90 then 
			player.x = screenWidth - player.width-90
		elseif (player.y <0 and (player.x  < map.doorWidth1 or player.x > map.doorWidth2)) then
			player.y = screenHeight - player.height - 90
		elseif player.y + player.height > screenHeight -90 then 
			player.y = screenHeight - player.height - 90
		end 
	end

	if map.imageNumber >= 1 then 
		if ((player.x >= 160- player.width and player.x  <= 320)  or (player.x >=480 - player.width and player.x <= 640))and (not map.isSlowed) then 
			if (player.y >= 240-player.height  and player.y <=360)  then 
				player.speed =  player.speed / 20
				map.isSlowed = true 
			else
				player.speed =200
				map.isSlowed = false
			end 
		else
			player.speed =200
			map.isSlowed = false
		end 
	end 
end 
	

function MAP_DRAW()
	love.graphics.draw(map.background)
	--love.graphics.draw(map.spikes,screenWidth/2-64/2 ,screenHeight-120,math.pi)--abajo
	--love.graphics.draw(map.spikes,0,screenHeight/2-120/2,.5* math.pi) -- izquierda
	--love.graphics.draw(map.spikes,screenWidth,screenHeight/2-160/2,1.5*math.pi)--derecha
	if not enemy.stopGenerate then 
		love.graphics.draw(map.spikes,screenWidth/2-64/2,15)--arriba
		map.newMapTransition()
	end 
	if map.imageNumber >=1 then 
		love.graphics.draw(map.mud, 160,240)
		love.graphics.draw (map.mud, 480,240)
	end 

end 


