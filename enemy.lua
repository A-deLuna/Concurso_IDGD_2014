enemy = {}
enemy.height = 30
enemy.width = 30
enemy.speed = 120
enemy.timer = 0
enemy.timerLimit = love.math.random(2,4)
enemy.amount = love.math.random(2,5)
enemy.side = love.math.random(1,4)
enemy.type = 1
enemy.easy = 1
enemy.medium = 2
enemy.hard = 3
enemy.totalTime = 0
enemy.distance = 40

function enemy.spawn (x , y, enemType, speed)
	if enemType == enemy.easy then 
		table.insert(enemy, {x = x, y = y, hp = 1, enemType = enemType, enemy.height, enemy.width, speed=speed, flag=false})
	end 
	if enemType == enemy.medium then 
		table.insert(enemy, {x = x, y = y, hp = 3, enemType = enemType, enemy.height, enemy.width, speed=speed  - 40, flag=false})
	end 
end 

function enemy.generate(dt)
	enemy.timer = enemy.timer + dt
	enemy.totalTime = enemy.totalTime + dt
	if enemy.timer > enemy.timerLimit then 
		for i = 1, enemy.amount do
			if enemy.side == 1 then 
				enemy.spawn(0-enemy.width,screenHeight / 2, enemy.type, enemy.speed)
			elseif enemy.side == 2 then 
				enemy.spawn(screenWidth /2 - enemy.width, 0-enemy.height, enemy.type, enemy.speed)
			elseif enemy.side == 3 then 
				enemy.spawn(screenWidth, screenHeight / 2 - enemy.height, enemy.type, enemy.speed)
			elseif enemy.side == 4 then
				enemy.spawn ( screenWidth /2 - enemy.width, screenHeight, enemy.type, enemy.speed)
			end
			enemy.side = love.math.random(1,4)
			
		
		end 
		enemy.amount = love.math.random(2,4)
		enemy.timerLimit = love.math.random(2,4)
		enemy.timer = 0
		----aumento de dificultad
		if enemy.totalTime > 50 then 
		enemy.type = love.math.random(1,2)
		end 
	end 
end

function enemy.AI(dt)
	for i, v in ipairs (enemy) do
		if v.x > player.x then 
			v.x = v.x - v.speed * dt 
		elseif v.x < player.x then 
			v.x = v.x + v.speed * dt 
		end 
		if v.y > player.y then 
			v.y = v.y - v.speed * dt 
		elseif v.y < player.y then 
			v.y = v.y + v.speed * dt
		end
	end  
end  

function enemy.overlapping() 
	for i,v in ipairs(enemy) do
		v.speed=enemy.speed
		v.flag = false
	end
	for i, v in ipairs (enemy) do 
		for j, k in ipairs(enemy) do 
			if v ~= k then 
				if ((v.x < k.x and k.x<v.x+enemy.width) and (v.y < k.y and k.y<v.y+enemy.height)) or 
			((v.x < k.x+enemy.width and k.x+enemy.width<v.x+enemy.width) and (v.y < k.y+enemy.height and k.y+enemy.height<v.y+enemy.height)) or 
			((v.x < k.x+enemy.width and k.x+enemy.width<v.x+enemy.width) and (v.y < k.y and k.y<v.y+enemy.height)) or 
			((v.x < k.x and k.x<v.x+enemy.width) and (v.y < k.y+enemy.height and k.y+enemy.height<v.y+enemy.height)) then  
					--v.x = k.x + enemy.width/2
					--v.y = k.y + enemy.width/2
					--k.x = v.x - enemy.width
					--k.y = v.y - enemy.width
					if not v.flag and not k.flag then
						v.speed=v.speed/2
						k.flag = true
					end
				end
			end 
		end 
	end 
end 

function enemy.draw() 
	for i, v in ipairs(enemy) do 
		if v.enemType == enemy.easy	then 
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill",v.x,v.y,enemy.width,enemy.height)
		elseif v.enemType == enemy.medium then
			love.graphics.setColor(0,0,255)
			love.graphics.rectangle("fill",v.x,v.y,enemy.width,enemy.height)
		end 
	end 
end 


function ENEMY_UPDATE(dt)
	enemy.generate(dt)
	enemy.AI(dt)
	enemy.overlapping()
end 

function ENEMY_DRAW()
	enemy.draw()
end
 