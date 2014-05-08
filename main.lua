require "powerup"
require "player"
require "enemy"
require "bullet"
require "gamepad"
require "explosion"
require "AnAL"
require "enemBullet"
require "map"
require "Highscores"
flux = require "flux"
Timer = require "hump.timer"
Gamestate = require "hump.gamestate"

require "game"
require "menu"
require "gameOver"
require "intro"

function love.load()
	Gamestate.registerEvents()
    Gamestate.switch(intro)
	gamepad.load()

	stageMusic = love.audio.newSource("sound/stage.mp3")
	stageMusic:setVolume(0.4)

	
end

function love.update(dt)
	flux.update(dt)
	Timer.update(dt)
	
end



function love.draw()
	
end
