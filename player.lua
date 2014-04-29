player = {}
function player.load()
	player.x = 500
	player.y = 500
	player.height = 30
	player.width = 30
	player.speed = 200
	player.paranoia = 0
	player.hp = 100
end

function player.draw()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end	

function player.movement(dt)
	if love.keyboard.isDown("w") then 
		player.y = player.y - player.speed * dt 
	end
	if love.keyboard.isDown("s") then 
		player.y = player.y + player.speed * dt
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt 
	end 
	if love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt 
	end 
end 

function player.screenBound()
	if  player.x < 0 then
		player.x = 0
	elseif player.x  + player.width > screenWidth then 
		player.x = screenWidth - player.width
	elseif player.y  < 0 then 
		player.y = 0
	elseif player.y + player.height > screenHeight then 
		player.y = screenHeight - player.height
	end 
end

function PLAYER_DRAW()
	player.draw()
end 

function PLAYER_UPDATE(dt)
	player.movement(dt)
	player.screenBound()
end 