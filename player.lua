player = {}
function player.load()
	player.x = 500
	player.y = 500
	player.height = 30
	player.width = 30
	player.speed = 200
	player.paranoia = 0
	player.hp = 3
	player.hitbox = 15 
	player.hpIcon = love.graphics.newImage("img/lives.jpg")
end

function player.draw()
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end	

function player.movement(dt)
	if love.keyboard.isDown("w") then 
		player.y = player.y - player.speed * dt 
	elseif love.keyboard.isDown("s") then 
		player.y = player.y + player.speed * dt
	else
	  	player.y = player.y + (player.speed*gamepad.ly) * dt
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt 
	elseif love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt 
	else
		player.x = player.x + (player.speed*gamepad.lx) * dt
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
function player.enemyColission()
	for i, v in ipairs (enemy) do 
		if ((v.x + enemy.width / 2) - (player.x - player.width / 2)) ^ 2 + 
			((v.y + enemy.width/2) - (player.y + player.width/2 )) ^ 2 < player.hitbox ^ 2 then 
			player.hp = player.hp -1
		end 

	end 
end 
function player.drawHealthPoints()
	love.graphics.setColor(0,176,0)
	love.graphics.print( "Lives:",0, 0, 0, 1, 1, 0, 0, 0, 0)
	i = 1
	while  i  < player.hp do 
		love.graphics.setColor(255,255,255)
		love.graphics.draw(player.hpIcon,i * 50, 20, 0, .2, .2, 0, 0, 0, 0)
		 i = i + 1
	end 
end 

function PLAYER_DRAW()
	player.draw()
	player.drawHealthPoints()
	player.enemyColission()
end 

function PLAYER_UPDATE(dt)
	player.movement(dt)
	player.screenBound()
end 