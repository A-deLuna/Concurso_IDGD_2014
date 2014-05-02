
require "player"
require "enemy"
require "bullet"
require "gamepad"

function love.load()
	player.load()
	gamepad.load()
	
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	
	love.graphics.setFont(love.graphics.newFont(15))
end
function love.update(dt)
	 PLAYER_UPDATE(dt)
	 ENEMY_UPDATE(dt)
	 BULLET_UPDATE(dt)
	 GAMEPAD_UPDATE()
	 end
	 function love.draw()
	 	PLAYER_DRAW()
	 	ENEMY_DRAW()
	BULLET_DRAW()	
end
