enemy = {}
function enemy.load()
	enemy.height = 30
	enemy.width = 30
	enemy.speed = 100
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
	enemy.lastSide = 0
	enemy.spawnRepetitions = 0
	enemy.shootTime=50
	enemy.tpTime=100
	enemy.stopGenerate = false
end

function enemy.spawn (x , y, enemType, speed)
	if enemType == enemy.easy then 
		table.insert(enemy, {x = x, y = y, hp = 1, enemType = enemType, enemy.height, enemy.width, speed=speed, flag=false})
	end 
	if enemType == enemy.medium then 
		table.insert(enemy, {x = x, y = y, hp = 3, enemType = enemType, enemy.height, enemy.width, speed=speed  - 50, flag=false})
	end
	if enemType == enemy.hard then 
		table.insert(enemy, {x = x, y = y, hp = 2, enemType = enemType, enemy.height, enemy.width, speed=speed  - 50, flag=false, indivTime=0, pastX=-48,pastY=-48})
	end

end 

function enemy.generate(dt)
	if not enemy.stopGenerate then 
		enemy.timer = enemy.timer + dt
		enemy.totalTime = enemy.totalTime + dt
		
		if enemy.timer > enemy.timerLimit then 
			for i = 1, enemy.amount do
				if enemy.side == 1 then 
					if enemy.lastSide == 1 then 
						enemy.spawnRepetitions = enemy.spawnRepetitions + 1
						enemy.spawn(0-enemy.width,screenHeight / 2 + 30 * enemy.spawnRepetitions, enemy.type, enemy.speed)
					else 
						enemy.spawnRepetitions = 0
						enemy.spawn(0-enemy.width,screenHeight / 2, enemy.type, enemy.speed)
					end 
					enemy.lastSide = 1 
				elseif enemy.side == 2 then 
					if enemy.lastSide == 2 then 
						enemy.spawnRepetitions = enemy.spawnRepetitions + 1
						enemy.spawn(screenWidth /2 + 30 * enemy.spawnRepetitions- enemy.width, -enemy.height, enemy.type, enemy.speed)
					else 
						enemy.spawnRepetitions = 0
						enemy.spawn(screenWidth /2 - enemy.width, 0-enemy.height, enemy.type, enemy.speed)
					end 
					enemy.lastSide = 2 
				elseif enemy.side == 3 then 
					if enemy.lastSide == 3 then 
						enemy.spawnRepetitions = enemy.spawnRepetitions + 1
						enemy.spawn( screenWidth, screenHeight / 2  + 30 * enemy.spawnRepetitions - enemy.height, enemy.type, enemy.speed)
					else 
						enemy.spawnRepetitions = 0
						enemy.spawn(screenWidth, screenHeight / 2 - enemy.height, enemy.type, enemy.speed)
					end 
					enemy.lastSide = 3 
				elseif enemy.side == 4 then
					if enemy.lastSide == 4 then 
						enemy.spawnRepetitions = enemy.spawnRepetitions + 1
						enemy.spawn ( screenWidth /2 + 30 * enemy.spawnRepetitions,  screenHeight, enemy.type, enemy.speed)
					else 
						enemy.spawn ( screenWidth /2 , screenHeight, enemy.type, enemy.speed)
						enemy.spawnRepetitions = 0
					end 
					enemy.lastSide = 4 
				end

				enemy.side = love.math.random(1,4)
				
			
			end 
			enemy.amount = love.math.random(2,4)
			enemy.timerLimit = love.math.random(2,4)
			enemy.timer = 0
			----aumento de dificultad
			if enemy.totalTime > 25 then 
				enemy.type = love.math.random(1,2)
			end 

			if enemy.totalTime > 50 then 
				enemy.type = love.math.random(1,3)
				if enemy.type==3 then enemy.amount = 1 end
			end 
		end
	end  
	if enemy.totalTime >  map.timeForNextLevel then 
		enemy.stopGenerate = true
	end 
end

function enemy.AI(dt)
	for i, v in ipairs (enemy) do
		if v.enemType == 3 then
			if v.indivTime > enemy.tpTime then 
				v.pastX = v.x 
				v.pastY = v.y
				v.x = love.math.random(love.window.getWidth())
				v.y = love.math.random(love.window.getHeight())
				v.indivTime=0
			end
			if (v.indivTime-2>enemy.shootTime and v.indivTime-2<enemy.shootTime+2) or (v.indivTime/2-2>enemy.shootTime and v.indivTime/2-2<enemy.shootTime+2)==0 then
				if v.x<love.window.getWidth() and v.x > 0 and v.y < love.window.getHeight() and v.y > 0 then
					enemBullet.spawn(v.x,v.y,math.atan2(player.y-(v.y+enemy.height/2),player.x-(v.x+enemy.width/2)))
				end
			end
			v.indivTime=v.indivTime+50*dt
		elseif v.x > player.x then 
			v.x = v.x - v.speed * dt 
		elseif v.x < player.x then 
			v.x = v.x + v.speed * dt 
		end 
		if v.enemType == 3 then
		elseif v.y > player.y then 
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
						v.speed=v.speed/100
						k.flag = true
					end
				end
			end 
		end 
	end 
end 

function drawIndivEnemy(self)
	if self.enemType == enemy.easy	then 
		love.graphics.setColor(0,love.math.random(255),0)
		love.graphics.rectangle("fill",self.x,self.y,enemy.width,enemy.height)
	elseif self.enemType == enemy.medium then
		love.graphics.setColor(0,0,love.math.random(255))
		love.graphics.rectangle("fill",self.x,self.y,enemy.width,enemy.height)
	elseif self.enemType == enemy.hard then
		love.graphics.setColor(love.math.random(170,255),0,love.math.random(255))
		love.graphics.rectangle("fill",self.x,self.y,enemy.width,enemy.height)
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