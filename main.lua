
require "player"
require "enemy"
function love.load()
	player.load()
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	
end
function love.update(dt)
	 PLAYER_UPDATE(dt)
	 ENEMY_UPDATE(dt)
end
function love.draw()
	PLAYER_DRAW()
	ENEMY_DRAW()	
end
