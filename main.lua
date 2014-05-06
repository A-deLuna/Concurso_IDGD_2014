require "powerup"
require "player"
require "enemy"
require "bullet"
require "gamepad"
require "explosion"
require "AnAL"
require "enemBullet"
require "map"
flux = require "flux"

function love.load()
	player.load()
	gamepad.load()
	enemy.load()
	powerup.load()

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

	piu = love.audio.newSource("sound/piu.mp3", "static")
	piu:setVolume(1.0)
	boom = love.audio.newSource("sound/boom.mp3", "static")
	boom:setVolume(1.0)
	music = love.audio.newSource("sound/music.mp3")
	music:setVolume(0.3)

	
end

function love.update(dt)
	flux.update(dt)
	if music:isStopped() then
		music:play()
	end
	if(not pause) then
		PLAYER_UPDATE(dt)
		ENEMY_UPDATE(dt)
		BULLET_UPDATE(dt)
		GAMEPAD_UPDATE()
		POWERUP_UPDATE(dt)
		ENEMBULLET_UPDATE(dt)
		if player.hp < 1 then 
			reset()
		end
	else
		pauseScreen:update(dt)
		linesAanim:update(dt)
		linesBanim:update(dt)
	end
	if enemy.stopGenerate then 
	MAP_UPDATE(dt)
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
	music:stop()
end

function love.draw()
	BULLET_DRAW()
	ENEMBULLET_DRAW()

	love.graphics.print(player.x,200,200)
	love.graphics.print(player.y,200,250)
	
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
		love.graphics.setColor(255,255,255)
	if pause then
	    pauseScreen:draw(screenWidth/2 - 100, 200)
	    linesAanim:draw(screenWidth/2 - 104, 198)
	    linesBanim:draw(screenWidth/2 - 104, 198)
	end
end
