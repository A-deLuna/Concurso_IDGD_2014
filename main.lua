<<<<<<< HEAD
require "player"
require "enemy"
function love.load()
	player.load()
	screenWidth = love.window.getWidth()
	screenHeight = love.window.getHeight()
end
function love.update(dt)
	 PLAYER_UPDATE(dt)
	 ENEMY_UPDATE(dt)
end
function love.draw()
	PLAYER_DRAW()
	ENEMY_DRAW()	
end
=======
function love.load(args)
	Width = love.graphics.getWidth()
	Height = love.graphics.getHeight()
	
	nivel = 1 
	numeroDeEnemigos = 4
	--hero
	hero = {}
	hero.x = 250
	hero.y = 250
	hero.speed = 150

	--enemies
	easyEnemy = {}
	easyEnemy.speed = 90
	x1 = 0
	x2 = Width /2 
	x3 = Width 
	x4 = Width /2
	y1 = Height /2
	y2 = 0
	y3 = Height /2 
	y4 = Height 

	hardEnemy = {x,y,speed = 125}
	
	enemyList1 = {{x,y,speed =easyEnemy.speed}}	

	enemyList2 = {{x,y,speed =easyEnemy.speed}}
	
	enemyList3 = {{x,y,speed =easyEnemy.speed}}

	enemyList4 = {{x,y,speed =easyEnemy.speed}}

	enemyList = {enemyList1,enemyList2,enemyList3,enemyList4}
	for n = 1, #enemyList do
			for m = 1, #enemyList[n] do
				if n ==1 then 
					enemyList[n][m].x = x1
					enemyList[n][m].y = y1
				elseif n == 2 then 
					enemyList[n][m].x = x2
					enemyList[n][m].y = y2
				elseif n == 3 then 
					enemyList[n][m].x = x3 
					enemyList[n][m].y = y3
				elseif n == 4 then 
					enemyList[n][m].x = x4 
					enemyList[n][m].y = y4  
				end 
			end 
		
	end
	 
	

	--bullets
	bulletSpeed = 400
	bullets = {}
	
	
	

end

function love.update(dt)
	--movimiento
	if love.keyboard.isDown("w") then
		hero.y = hero.y - hero.speed * dt
	end
	if love.keyboard.isDown("s")then 
		hero.y = hero.y + hero.speed * dt
	end
	if love.keyboard.isDown("a")then
		hero.x = hero.x - hero.speed * dt
	end
	if love.keyboard.isDown("d")then
		hero.x = hero.x + hero.speed * dt
	end

	-- que no se salga del borde
	if(hero.x > Width) then
		hero.x = Width
	elseif hero.x < 0 then
		hero.x = 0
	elseif hero.y > Height then
 		hero.y = Height 
	elseif hero.y < 0 then
	    hero.y = 0
	end
	

	--enemigos ai

	for n =1, #enemyList do
		for m =1, #enemyList[n] do 
			
			if enemyList[n][m].x > hero.x then
				enemyList[n][m].x = enemyList[n][m].x - enemyList[n][m].speed*dt
			else 
				enemyList[n][m].x = enemyList[n][m].x + enemyList[n][m].speed*dt
			end	
			if enemyList[n][m].y > hero.y then
				enemyList[n][m].y = enemyList[n][m].y - enemyList[n][m].speed* dt
			else
				enemyList[n][m].y = enemyList[n][m].y + enemyList[n][m].speed* dt
			end
		end
	end
	
	--movimiento de balas
	for i,v in ipairs(bullets) do
        v.x = v.x + (v.dx * dt)
        v.y = v.y + (v.dy * dt)
    end

    

    bulletCollition() 
    if numeroDeEnemigos == 0 then 
    	llenarNivel()
    end 
end

function love.draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.circle("fill",hero.x,hero.y,10,10)

	love.graphics.setColor(255,255,44,255)
	for n =1, #enemyList do
		for m =1, #enemyList[n] do
			love.graphics.rectangle("fill",enemyList[n][m].x,enemyList[n][m].y,20,20) 
		end
	end
	--bullets
	love.graphics.setColor(128, 13, 128,255)
    for i,v in ipairs(bullets) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end
	
end
-- llenar el nivel
function llenarNivel()
	nivel = nivel + 1
	if nivel == 2 then 
		for n = 1, #enemyList do
			numeroDeEnemigos = numeroDeEnemigos + 1
			table.insert (enemyList[n],{x,y,speed = easyEnemy.speed})
			 
		end 
	end 
	for n = 1, #enemyList do
		for m = 1, #enemyList[n] do
			if n ==1 then 
				enemyList[n][m].x = x1
				enemyList[n][m].y = y1
			elseif n == 2 then 
				enemyList[n][m].x = x2
				enemyList[n][m].y = y2
			elseif n == 3 then 
				enemyList[n][m].x = x3 
				enemyList[n][m].y = y3
			elseif n == 4 then 
				enemyList[n][m].x = x4 
				enemyList[n][m].y = y4  
			end 
		end 
	end
end 
--manejar los disparos
function love.mousepressed(x, y, button)
	if button == "l" then
		mouseX = x
		mouseY = y
		angle = math.atan2(mouseY - hero.y, mouseX - hero.x)
		bulletDx = bulletSpeed * math.cos(angle)
		bulletDy = bulletSpeed * math.sin(angle)
		table.insert(bullets, {x = hero.x, y = hero.y, dx = bulletDx, dy = bulletDy})

	end 
end

-- checa si la bala choco contra un enemigo, lo elimina
function bulletCollition()
	for i=1, #enemyList do
		for j =1, #enemyList[i] do
			for k=1 , #bullets do 
				if(math.abs(enemyList[i][j].x - bullets[k].x) <= 14) and (math.abs(enemyList[i][j].y - bullets[k].y) <= 14) then 
					table.remove(enemyList[i],j)
					table.remove (bullets,k)
					numeroDeEnemigos = numeroDeEnemigos - 1
					break
				
				end 
			end
		end
	end

end
function love.keyreleased(key)
	if key == "i" then 
		enemyList1 = {{x,y,speed =easyEnemy.speed}}	

		enemyList2 = {{x,y,speed =easyEnemy.speed}}
	
		enemyList3 = {{x,y,speed =easyEnemy.speed}}

		enemyList4 = {{x,y,speed =easyEnemy.speed}}

		enemyList = {enemyList1,enemyList2,enemyList3,enemyList4}

		for n = 1, #enemyList do
			for m = 1, #enemyList[n] do
				if n ==1 then 
					enemyList[n][m].x = x1
					enemyList[n][m].y = y1
				elseif n == 2 then 
					enemyList[n][m].x = x2
					enemyList[n][m].y = y2
				elseif n == 3 then 
					enemyList[n][m].x = x3 
					enemyList[n][m].y = y3
				elseif n == 4 then 
					enemyList[n][m].x = x4 
					enemyList[n][m].y = y4  
				end 
			end 
		end
	end 
	if key == "escape" then 
		love.event.quit()
	end

end 
>>>>>>> 3e7003b4105b604e351eb11bebb1801c3d8252f2
