
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
