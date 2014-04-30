bullet = {}
bullet.speed = 600
bullet.radius = 5

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
end 

function BULLET_DRAW()
	bullet.draw()
end 

function love.mousepressed(x, y, button)
	--while love.mouse.isDown(button)	do
		if button == "l" then 
			local x = x
			local y = y 
			local angle = math.atan2(y - player.y, x - player.x)

			bullet.spawn(player.x + player.width /2 ,player.y + player.height /2 ,angle)
		end 
	--end 
end 