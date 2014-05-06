map  = {}

map.type = 0 

map.pain = 1
map.woods = 2
map.boss = 3
map.doorHeight1 =230
map.doorHeight2 = 360
map.doorWidth1 = 260
map.doorWidth2 = 430
map.timeForNextLevel = 55
map.positionX = 0
map.positionY = 0

function map.newMapTransition()
	
	if player.x + player.width < 0 then 
		--player.outOfBounds = true
		--map.positionX = screenWidth - player.width 
		--map.positionY = player.y
		flux.to(player,4,{x = screenWidth-player.width, y = player.y})
		love.graphics.setBackgroundColor(240,110,45)
		enemy.stopGenerate = false
	elseif player.x > screenWidth then 
		--player.outOfBounds = true
		--map.positionX = 0
		--map.positionY = player.y
		flux.to(player,4,{x = 	0,y = player.y})
		love.graphics.setBackgroundColor(140,110,45)
		enemy.stopGenerate = false
	elseif player.y + player.height < 0 then 
		--player.outOfBounds = true
		--map.positionX = player.x
		--map.positionY = screenHeight - player.height 
		flux.to(player,4,{x =player.x, y = screenHeight - player.height })

		love.graphics.setBackgroundColor(140,210,45)
		enemy.stopGenerate = false
	elseif player. y  > screenHeight then 
		--player.outOfBounds = true
		--map.positionX = player.x 
		--map.positionY = 0
		flux.to(player,4,{x = player.x,y = 0})

		love.graphics.setBackgroundColor(140,110,145)
		enemy.stopGenerate = false
	end 

end  
--[[
function map.movePlayerTo(dt)
	if player.outOfBounds then 	
		if player.x < map.positionX then 
		player.x = player.x + player.speed * dt
		end 
		if player.x > map.positionX then 
		player.x = player.x - player.speed * dt
		end 
		if player.y < map.positionY then 
		player.y = player.y + player.speed * dt
		end 
		if player.y > map.positionY then 
		player.y = player.y - player.speed * dt 
		end 
	
	end 
	if((player.x >  map.positionX-1 and player.x < map.positionX + 1) and (player.y >map.positionY -1  and player.y < map.positionY + 1 )) then 
		player.outOfBounds = false
	end 
end 
--]]

function MAP_UPDATE(dt)
	
	--map.movePlayerTo(dt)
	map.newMapTransition()
	
end 
