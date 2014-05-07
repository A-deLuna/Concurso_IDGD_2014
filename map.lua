map  = {}

map.type = 0 

map.pain = 1
map.woods = 2
map.boss = 3
map.doorHeight1 = 240
map.doorHeight2 = 360
map.doorWidth1 = 340
map.doorWidth2 = 460
map.timeForNextLevel = 60
map.positionX = 0
map.positionY = 0
map.background = love.graphics.newImage('img/background0.png')
function map.newMapTransition()

	if player.x + player.width < 0 then 

		table.remove(powerup)
		flux.to(player,4,{x = screenWidth-player.width, y = player.y})
		
		love.graphics.setBackgroundColor(240,110,45)
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end)
		enemy.stopGenerate = false
	elseif player.x > screenWidth then 

		table.remove(powerup)
		flux.to(player,4,{x = 	0,y = player.y})
		love.graphics.setBackgroundColor(140,110,45)
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end) 
		enemy.stopGenerate = false
	elseif player.y + player.height < 0 then 

		table.remove(powerup)
		flux.to(player,4,{x =player.x, y = screenHeight - player.height })

		love.graphics.setBackgroundColor(140,210,45)
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end)
		enemy.stopGenerate = false
	elseif player. y  > screenHeight then 

		table.remove(powerup)
		flux.to(player,4,{x = player.x,y = 0})

		love.graphics.setBackgroundColor(140,110,145)
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end) 
		enemy.stopGenerate = false
	end 

end  

function map.loadMap()
	if map.type == 1 then 
		
	end 	
end 

function MAP_UPDATE(dt)
	
	--map.movePlayerTo(dt)
	
	
end 
function MAP_DRAW()
	love.graphics.draw(map.background)
end 
