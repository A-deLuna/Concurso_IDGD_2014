enemy = {}
enemy.height = 30
enemy.width = 30
enemy.speed = 150
enemy.timer = 0
enemy.timerLimit = love.math.random(2,4)
enemy.amount = love.math.random(2,5)
enemy.side = love.math.random(1,4)
enemy.type = 1
enemy.easy = 1
enemy.medium = 2
enemy.hard = 3
enemy.totalTime = 0

function enemy.spawn (x , y, enemType)
	if enemType == enemy.easy then 
		table.insert(enemy, {x = x, y = y, hp = 1, enemType = enemType, enemy.height, enemy.width, enemy.speed })
	end 
	if enemType == enemy.medium then 
		table.insert(enemy, {x = x, y = y, hp = 3, enemType = enemType, enemy.height, enemy.width, enemy.speed  + 10})
	end 
end 

function enemy.generate(dt)
	enemy.timer = enemy.timer + dt
	enemy.totalTime = enemy.totalTime + dt
	if enemy.timer > enemy.timerLimit then 
		for i = 1, enemy.amount do
			if enemy.side == 1 then 
				enemy.spawn(0-enemy.width,screenHeight / 2, enemy.type)
			elseif enemy.side == 2 then 
				enemy.spawn(screenWidth /2 - enemy.width, 0-enemy.height, enemy.type)
			elseif enemy.side == 3 then 
				enemy.spawn(screenWidth, screenHeight / 2 - enemy.height, enemy.type)
			elseif enemy.side == 4 then
				enemy.spawn ( screenWidth /2 - enemy.width, screenHeight, enemy.type)
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
			v.x = v.x - enemy.speed * dt 
		elseif v.x < player.x then 
			v.x = v.x + enemy.speed * dt 
		end 
		if v.y > player.y then 
			v.y = v.y - enemy.speed * dt 
		elseif v.y < player.y then 
			v.y = v.y + enemy.speed * dt
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
end 

function ENEMY_DRAW()
	enemy.draw()
end
 