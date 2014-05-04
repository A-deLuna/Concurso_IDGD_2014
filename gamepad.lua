gamepad = {}

function gamepad.load()
	gpads = love.joystick.getJoysticks()
	gamepad.lx=0
	gamepad.rx=0
	gamepad.ly=0
	gamepad.ry=0
	gamepad.isDown={}
	for i=0,11,1 do
		gamepad.isDown[i]=false
	end
end

function gamepad.debug()
	love.graphics.print(player.angle,10,screenHeight-50)
	love.graphics.print(gamepad.ry,10,screenHeight-20)
end

function gamepad.update()
	for i,j in pairs(gpads) do
    	gamepad.lx=j:getAxis(1)
		gamepad.rx=j:getAxis(3)
		gamepad.ly=j:getAxis(2)
		gamepad.ry=j:getAxis(4)
		for c=1, 12, 1 do
			gamepad.isDown[c]=j:isDown(c)
		end
  	end
end

function GAMEPAD_UPDATE(dt)
	gamepad.update()
end	