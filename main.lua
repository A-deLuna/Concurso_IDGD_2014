require "powerup"
require "player"
require "enemy"
require "bullet"
require "gamepad"
require "explosion"
require "AnAL"

function love.load()
	player.load()
	gamepad.load()
	enemy.load()

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	
	love.graphics.setFont(love.graphics.newFont(15))

	pause = false
	pauseStrip=love.graphics.newImage("img/pause.png")
	pauseScreen=newAnimation(pauseStrip, 173,45,0.1,0)
	linesA=love.graphics.newImage("img/line.png")
	linesAanim=newAnimation(linesA, 179,51,0.1,0)
	linesB=love.graphics.newImage("img/linex.png")
	linesBanim=newAnimation(linesB, 179,51,0.1,0)
	pausetimer = .1

end

function love.update(dt)
	if(not pause) then
		PLAYER_UPDATE(dt)
		ENEMY_UPDATE(dt)
		BULLET_UPDATE(dt)
		GAMEPAD_UPDATE()
		POWERUP_UPDATE()
		if player.hp == 0 then 
			reset()
		end
	else
		pauseScreen:update(dt)
		linesAanim:update(dt)
		linesBanim:update(dt)
	end


	
	for i, j in pairs(gpads) do
		if(pausetimer>=.1) then
			if j:isDown(10) then
				if not pause then
					pause=true
				else
					pause=false
				end
			end
			pausetimer=0
		else
		    pausetimer= pausetimer+ dt

		end
	end
	explosion.update(dt)
end

function love.keypressed(key, isrepeat)
	if key == "p" then
		if not pause then
			pause=true
		else
			pause=false
		end
	end

	if key == "r" then
		reset()
	end
end

function reset()
	love.load()
	for i, j in ipairs(enemy) do
		enemy[i] = nil
	end
	for i, j in ipairs(powerup) do
		powerup[i] = nil
	end
	for i, j in ipairs(bullet) do
		bullet[i] = nil
	end
end

function love.draw()
	if pause then
    pauseScreen:draw(screenWidth/2 - 100, 200)
    linesAanim:draw(screenWidth/2 - 104, 198)
    linesBanim:draw(screenWidth/2 - 104, 198)
	end
	
	
	BULLET_DRAW()

	num = -enemy.width
	while num < screenHeight do
		for a, b in ipairs(enemy) do
			if b.y > num-1 and b.y<=num then
				drawIndivEnemy(b)
			end
		end
		if player.y>num-1 and player.y<=num then 
			PLAYER_DRAW()	
		end
		num=num+1
	end
	player.score()
	powerup.draw()
	explosion.draw()
	player.drawHealthPoints()


	if player.ammo ~= 0 then
		love.graphics.setColor(255,255,255)
		love.graphics.print(player.ammo, screenWidth-50, 10)
	end
	enemy.debug()
end
