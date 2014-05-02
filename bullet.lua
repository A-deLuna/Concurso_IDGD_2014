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
			if ((v.x < q.x-bullet.radius and q.x-bullet.radius<v.x+enemy.width) and (v.y < q.y-bullet.radius and q.y-bullet.radius<v.y+enemy.height)) or 
			((v.x < q.x+bullet.radius and q.x+bullet.radius <v.x+enemy.width) and (v.y < q.y+bullet.radius and q.y+bullet.radius+player.height<v.y+enemy.height)) or 
			((v.x < q.x+bullet.radius and q.x+bullet.radius<v.x+enemy.width) and (v.y < q.y-bullet.radius and q.y-bullet.radius<v.y+enemy.height)) or 
			((v.x < q.x-bullet.radius and q.x-bullet.radius<v.x+enemy.width) and (v.y < q.y+bullet.radius and q.y+bullet.radius<v.y+enemy.height)) then 
				v.hp = v.hp - 1 
				if ( v.hp < 1) then 
					powerup.spawn(v.x,v.y)
					table.remove(enemy, i)
				end 
				explosion.spawn(q.x, q.y)
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