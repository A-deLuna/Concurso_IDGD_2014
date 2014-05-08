player = {}
function player.load()
	player.x = 376
	player.y = 269
	player.height = 62
	player.width = 48
	player.speed = 200
	player.paranoia = 0
	player.hp = 3
	player.hitbox = 15 
	player.hpIcon = love.graphics.newImage("img/lives.png")
	player.invTimer = 2
	player.inv = 2
	player.invincible = false
	player.bullettype=0
	player.secbullettype = 0
	player.ammo=0
	player.angle= math.pi/2
	player.scoreValue=0
	player.outOfBounds = false
	love.graphics.setColor(255,255,255)
	x=1
	character={}
	CFront=love.graphics.newImage("img/Cleanington-front.png")
character[1]=newAnimation(CFront, 48,62,0.1,0)
	CBack=love.graphics.newImage("img/cleanington-back.png")
character[0]=newAnimation(CBack, 48,62,0.1,0)
	CLeft=love.graphics.newImage("img/cleanington-left.png")
character[2]=newAnimation(CLeft, 48,62,0.1,0)
	CRight=love.graphics.newImage("img/cleanington-right.png")
	character[3]=newAnimation(CRight, 48,62,0.1,0)
	
end

function player.draw()
	love.graphics.setFont(love.graphics.newFont(20))
	if player.invTimer>=player.inv or (player.invTimer*100-((player.invTimer*100)%1)) % 2 == 0 then
		love.graphics.setColor(255,255,255)
		--love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
		character[x]:draw(player.x,player.y)
	end
end	

function player.movement(dt)
	if love.keyboard.isDown("w") then 
		player.y = player.y - player.speed * dt
		angley=3*math.pi/4
		character[0]:draw(player.x,player.y)
		x=0
		character[x]:update(dt)
	elseif love.keyboard.isDown("s") then 
		player.y = player.y + player.speed * dt
		angley=math.pi/2
		character[1]:draw(player.x,player.y)
		x=1
		character[x]:update(dt)
	else
	  	player.y = player.y + (player.speed*gamepad.ly) * dt
	  	angley=gamepad.ly
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * dt 
		anglex=math.pi
		character[2]:draw(player.x,player.y)
		x=2
		character[x]:update(dt)
	elseif love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt 
		anglex=0
		character[3]:draw(player.x,player.y)
		x=3
		character[x]:update(dt)
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
	if (not enemy.stopGenerate) then 	
		if  player.x < 90 then
			player.x = 90
		end
		if player.x  + player.width > screenWidth-90 then 
			player.x = screenWidth - player.width-90
		end 
		if player.y  < 90 then 
			player.y = 90
		end 
		if player.y + player.height > screenHeight-90 then 
			player.y = screenHeight - player.height-90
		end 
	
	end 
end

function player.hurt()
	if not player.invincible then
		player.hp = player.hp -1
		player.invTimer = 0
		player.invincible = true
	end
end

function player.enemyColission(dt)
	if(player.invTimer >= player.inv) then
		for i, v in ipairs (enemy) do 
			if (((v.x < player.x and player.x<v.x+enemy.width) and (v.y < player.y and player.y<v.y+enemy.height)) or 
			((v.x < player.x+player.width and player.x+player.width<v.x+enemy.width) and (v.y < player.y+player.height and player.y+player.height<v.y+enemy.height)) or 
			((v.x < player.x+player.width and player.x+player.width<v.x+enemy.width) and (v.y < player.y and player.y<v.y+enemy.height)) or 
			((v.x < player.x and player.x<v.x+enemy.width) and (v.y < player.y+player.height and player.y+player.height<v.y+enemy.height)))then 
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
	love.graphics.setColor(255,255,255)
	love.graphics.print( "Lives:",10, 10, 0, 1, 1, 0, 0, 0, 0)
	i = 0
	while  i  < player.hp do 
		love.graphics.setColor(255,255,255)
		love.graphics.draw(player.hpIcon,i * 50 + 10, 30, 0, 1, 1, 0, 0, 0, 0)
		 i = i + 1
	end
end 

function player.score()
	love.graphics.setColor(255,255,255)
	love.graphics.print("Score: ", love.graphics.getWidth()-200, 10, 0, 1, 1, 0, 0, 0, 0)
	love.graphics.print(player.scoreValue, love.graphics.getWidth()-130,10,0,1,1,0,0,0,0)
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