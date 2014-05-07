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
map.imageNumber= 0
map.background = love.graphics.newImage('img/background0.png')
map.isUpdated = false
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
		flux.to(player,4,{x =player.x, y = screenHeight - player.height })

		
		
		Timer.add(4, function () map.timeForNextLevel = map.timeForNextLevel + 55 end)
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
	
	
end 
function MAP_DRAW()
	love.graphics.draw(map.background)
end 
