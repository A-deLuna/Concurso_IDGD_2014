gamepad = {}

function gamepad.load()
	gpads = love.joystick.getJoysticks()
	gamepad.lx=0
	gamepad.rx=0
	gamepad.ly=0
	gamepad.ry=0
end

function gamepad.update()
	for i,j in pairs(gpads) do
    	gamepad.lx=j:getAxis(1)
		gamepad.rx=j:getAxis(3)
		gamepad.ly=j:getAxis(2)
		gamepad.ry=j:getAxis(4)
  	end
end

function GAMEPAD_UPDATE(dt)
	gamepad.update()
end	