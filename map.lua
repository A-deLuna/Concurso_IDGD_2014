map  = {}
function map.load()
	map.type = 0 

	map.pain = 1
	map.woods = 2
	map.boss = 3
	map.doorHeight1 = 240
	map.doorHeight2 = 360
	map.doorWidth1 = 340
	map.doorWidth2 = 460
	map.timeForNextLevel = 10
	map.positionX = 0
	map.positionY = 0
	map.imageNumber= 0
	map.background = love.graphics.newImage('img/background0.png')
	map.isUpdated = false
	map.isSlowed = false
end
function map.newMapTransition()
--[[
	if player.x + player.width < 0 then 

		table.remove(powerup)
		flux.to(player,4,{x = screenWidth-player.width, y = player.y})
		
		
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end)
		enemy.stopGenerate = false
	elseif player.x > screenWidth then 

		table.remove(powerup)
		flux.to(player,4,{x = 	0,y = player.y})
		
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end) 
		enemy.stopGenerate = false
	]]--
	if player.y + player.height < 0 then 

		table.remove(powerup)
		map.loadMap()
		player.x = screenWidth/2 
		player.y = screenHeight + player.height
		--flux.to(player,4,{x =player.x, y = screenHeight - player.height })

		
		
		Timer.add(2, function () map.timeForNextLevel = map.timeForNextLevel + 55 end)
		enemy.stopGenerate = false
	end 
	--[[	
	elseif player. y  > screenHeight then 

		table.remove(powerup)
		flux.to(player,4,{x = player.x,y = 0})

		
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end) 
		enemy.stopGenerate = false
	end 
	]]--

end  
function map.update()
	if not map.isUpdated then 
		map.loadMap()
	else 
		map.newMapTransition()
	end 
 
end 

function map.loadMap()
	map.imageNumber = map.imageNumber + 1 
	map.background = love.graphics.newImage('img/background'..map.imageNumber.. '.png')
	map.isUpdated = true
end 

function MAP_UPDATE(dt)
	map.playerBounds()
end 
function map.playerBounds()
	if map.imageNumber  == 1 then 
		if  player.x < 0 then
			player.x = 0
		elseif player.x  + player.width > screenWidth then 
			player.x = screenWidth - player.width
		elseif (player.y <0 and (player.x  < map.doorWidth1 or player.x > map.doorWidth2)) then
			player.y = 0
		elseif player.y + player.height > screenHeight then 
			player.y = screenHeight - player.height
		end 
	end

	if map.imageNumber == 2 or map.imageNumber == 3 then 
		if ((player.x >= 160- player.width and player.x  <= 320)  or (player.x >=480 - player.width and player.x <= 640))and (not map.isSlowed) then 
			if (player.y >= 120-player.height  and player.y <=240)  or (player.y >= 360-player.height and player.y <= 480)then 
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
end 
