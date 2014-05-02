bullet = {}
bullet.speed = 600
bullet.radius = 5
bullet.timer = 0
bullet.type = {{fireRate = 0.25}} 

function bullet.spawn(x, y, angle)
	table.insert(bullet, {x = x, y = y, dx = bullet.speed * math.cos(angle), dy = bullet.speed * math.sin(angle)} )
end 

function bullet.draw()
	for i,v in ipairs(bullet) do 
		love.graphics.setColor(225,225,225)
		love.graphics.circle("fill", v.x , v.y , bullet.radius, 10)
	end 
end 

function bullet.update(dt)
	for i, v in ipairs(bullet) do 
		v.x = v.x + v.dx * dt
		v.y = v.y + v.dy * dt 
	end
end 

function bullet.collition()
	for i, v in ipairs(enemy) do 
		for n, q in ipairs (bullet ) do 
			local dist  = math.sqrt((v.y - q.y)^2 + (v.x - q.x)^2)
			if (dist < bullet.radius + player.width) then 
				v.hp = v.hp - 1 
				if ( v.hp == 0) then 
					table.remove(enemy, i)
				end 
				table.remove(bullet, n)

			end  
		end 
	end 
end  



function BULLET_UPDATE(dt)
	bullet.update(dt)
	bullet.collition()
	bullet.shoot(dt)
end 

function BULLET_DRAW()
	bullet.draw()
end 
function bullet.shoot(dt)
	if  bullet.timer > bullet.type[1].fireRate then 
		if love.mouse.isDown("l") then 
			local x = love.mouse.getX()
			local y = love.mouse.getY()
			local angle = math.atan2(y - player.y, x - player.x)
			bullet.spawn(player.x + player.width /2 ,player.y + player.height /2 ,angle)
			bullet.timer = 0			
		elseif (gamepad.rx ~= 0 and gamepad.ry ~= 0) then
			local gpadangle = math.atan2(gamepad.ry, gamepad.rx)
			bullet.spawn(player.x + player.width /2 ,player.y + player.height /2 ,gpadangle)
			bullet.timer=0
		end
	end
	bullet.timer = bullet.timer + dt
end 