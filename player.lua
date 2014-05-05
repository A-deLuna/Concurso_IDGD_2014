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
	player.invTimer = 2
	player.inv = 2
	player.invincible = false
	player.bullettype=0
	player.ammo=0
	player.angle= math.pi/2
	player.scoreValue=0
end

function player.draw()
	if player.invTimer>=player.inv or (player.invTimer*100-((player.invTimer*100)%1)) % 2 == 0 then
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
	end
end	

function player.movement(dt)
	if love.keyboard.isDown("w") then 
		player.y = player.y - player.speed * dt
		angley=3*math.pi/4
	elseif love.keyboard.isDown("s") then 
		player.y = player.y + player.speed * dt
		angley=math.pi/2
	else
	  	player.y = player.y + (player.speed*gamepad.ly) * dt
	  	angley=gamepad.ly
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt 
		anglex=math.pi
	elseif love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt 
		anglex=0
	else
		player.x = player.x + (player.speed*gamepad.lx) * dt
		anglex=gamepad.lx
	end
	player.angle=math.tan(angley,anglex)
end

function player.angleUpdate()
	if love.keyboard.isDown("w") then
		angley=3*math.pi/2
	end
	if love.keyboard.isDown("s") then 
		angley=math.pi/2
	end
	if gamepad.ly ~= 0  then
	  	angley=gamepad.ly
	end
	if love.keyboard.isDown("a") then
		anglex=math.pi
	end
	if love.keyboard.isDown("d") then

		anglex=0
	end
	if gamepad.lx ~= 0 then
		anglex=gamepad.lx
	end
	player.angle=math.atan2(angley,anglex)
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

function player.hurt()
	player.hp = player.hp -1
	player.invTimer = 0
	player.invincible = true
end

function player.enemyColission(dt)
	if(player.invTimer >= player.inv) then
		for i, v in ipairs (enemy) do 
			if (((v.x < player.x and player.x<v.x+enemy.width) and (v.y < player.y and player.y<v.y+enemy.height)) or 
			((v.x < player.x+player.width and player.x+player.width<v.x+enemy.width) and (v.y < player.y+player.height and player.y+player.height<v.y+enemy.height)) or 
			((v.x < player.x+player.width and player.x+player.width<v.x+enemy.width) and (v.y < player.y and player.y<v.y+enemy.height)) or 
			((v.x < player.x and player.x<v.x+enemy.width) and (v.y < player.y+player.height and player.y+player.height<v.y+enemy.height))) and not player.invincible then 
					player.hurt()
					
					table.remove(enemy, i)
					

			end 
		end
	end
	if(player.invTimer < player.inv) then 
		player.invTimer = player.invTimer + (player.inv/2)*dt
	end
end 
function player.drawHealthPoints()
	love.graphics.setColor(0,176,0)
	love.graphics.print( "Lives:",10, 10, 0, 1, 1, 0, 0, 0, 0)
	i = 0
	while  i  < player.hp do 
		love.graphics.setColor(255,255,255)
		love.graphics.draw(player.hpIcon,i * 50 + 10, 30, 0, .2, .2, 0, 0, 0, 0)
		 i = i + 1
	end
end 

function player.score()
	love.graphics.setColor(0,176,0)
	love.graphics.print("Score: ", love.graphics.getWidth()-200, 10, 0, 1, 1, 0, 0, 0, 0)
	love.graphics.print(player.scoreValue, love.graphics.getWidth()-150,10,0,1,1,0,0,0,0)
end
function PLAYER_DRAW()
	player.draw()
end 

function PLAYER_UPDATE(dt)
	player.movement(dt)
	player.screenBound()
	player.enemyColission(dt)
	if player.invTimer >= player.inv then
		player.invincible = false
	end
	if player.ammo == 0 then
		player.bullettype = 0
	end
	player.angleUpdate()
end 