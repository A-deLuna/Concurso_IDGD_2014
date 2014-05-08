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

	music = love.audio.newSource("sound/music.mp3")
	music:setVolume(0.3/50)

	
end

function love.update(dt)
	flux.update(dt)
	Timer.update(dt)
	
end



function love.draw()
	
end
