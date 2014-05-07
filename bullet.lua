bullet = {}
bullet.speed = 600
bullet.radius = 5
bullet.timer = 0
bullet.type = {{fireRate = 0.25}}

function bullet.spawn(x, y, angle,type)
	if type==2 then
		table.insert(bullet, {x = x, y = y, dx = bullet.speed * math.cos(angle - math.pi/16), dy = bullet.speed * math.sin(angle - math.pi/16), type=10, angle=angle-math.pi/16, radius = bullet.radius} )
		table.insert(bullet, {x = x, y = y, dx = bullet.speed * math.cos(angle), dy = bullet.speed * math.sin(angle), type=11, angle=angle, radius = bullet.radius} )
		table.insert(bullet, {x = x, y = y, dx = bullet.speed * math.cos(angle + math.pi/16), dy = bullet.speed * math.sin(angle + math.pi/16), type=12, angle=angle+math.pi/16, radius = bullet.radius} )
	elseif type==3 then
		table.insert(bullet, {x = x, y = y, dx = bullet.speed * math.cos(angle), dy = bullet.speed * math.sin(angle), type=type, angle=angle, radius = bullet.radius+5})
	elseif type==0 or player.ammo>0 then
		table.insert(bullet, {x = x, y = y, dx = bullet.speed * math.cos(angle), dy = bullet.speed * math.sin(angle), type=type, angle=angle, radius = bullet.radius} )
	end 
	if type~=0 then
		player.ammo=player.ammo-1
	end
end 

function bullet.draw()
	for i,v in ipairs(bullet) do 
		if v.type==1 then
			love.graphics.setColor(255,178,0)
			love.graphics.circle("fill", v.x , v.y , v.radius, 10)
		elseif v.type==3 then
			love.graphics.setColor(175,100,255)
			love.graphics.circle("fill", v.x , v.y , v.radius, 10)
		elseif v.type==10 then 
			love.graphics.setColor(0,0,255)
			love.graphics.circle("fill", v.x , v.y , v.radius, 10)
		elseif v.type==11 then 
			love.graphics.setColor(255,255,255)
			love.graphics.circle("fill", v.x , v.y , v.radius, 10)
		elseif v.type==12 then
			love.graphics.setColor(255,0,0)
			love.graphics.circle("fill", v.x , v.y , v.radius, 10)
		else
			love.graphics.setColor(225,225,225)
			love.graphics.circle("fill", v.x , v.y , v.radius, 10)
		end
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
					player.scoreValue=player.scoreValue+100
				end
				-- AQUI ESTAN LOS TIPOS DE BALAS QUE SE VAN A LLAMAR
				if q.type==1 then
					explosion.spawn(q.x, q.y)
					
				end 

				if q.type~=3 then
					table.remove(bullet, n)
				end
			elseif q.x < 0 or q.x > love.window.getWidth() or q.y<0 or q.y>love.window.getHeight() then
				table.remove(bullet, n)
				if q.type==1 then
					explosion.spawn(q.x, q.y)
				end
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
		if love.mouse.isDown("l") or love.mouse.isDown("r") then 
			local x = love.mouse.getX()
			local y = love.mouse.getY()
			local angle = math.atan2(y - player.y, x - player.x)
			if love.mouse.isDown("l") then 
				type = 0 
			else 
				type = player.bullettype 
			end
			bullet.spawn(player.x + player.width /2 ,player.y + player.height /2 ,angle,type)

			bullet.timer = 0			 
			piu:play()
		elseif gamepad.isDown[7] or gamepad.isDown[8] then
			if (gamepad.rx ~= 0 and gamepad.ry ~= 0) then
			 	gpadangle = math.atan2(gamepad.ry, gamepad.rx)
			else
			    gpadangle = player.angle
			end
			if gamepad.isDown[8] then 
				type = 0 
			else 
				type = player.bullettype
			end
			bullet.spawn(player.x + player.width /2 ,player.y + player.height /2 ,gpadangle,type)
			bullet.timer=0
			piu:play()
		end
	end
	bullet.timer = bullet.timer + dt
end 