enemBullet = {}
enemBullet.speed = 600
enemBullet.radius = 5
enemBullet.timer = 0
enemBullet.type = {{fireRate = 0.25}}

function enemBullet.spawn(x, y, angle)
		table.insert(enemBullet, {x = x, y = y, dx = enemBullet.speed * math.cos(angle), dy = enemBullet.speed * math.sin(angle), angle=angle, radius = enemBullet.radius} )
end 

function enemBullet.draw()
	for i,v in ipairs(enemBullet) do 
		love.graphics.setColor(255,255,0)
		love.graphics.circle("fill", v.x , v.y , v.radius, 10)
	end 
end 

function enemBullet.update(dt)
	for i, v in ipairs(enemBullet) do 
		v.x = v.x + v.dx * dt
		v.y = v.y + v.dy * dt 
	end
end 

function enemBullet.collition() 
	for n, q in ipairs (enemBullet ) do 
		if ((player.x < q.x-enemBullet.radius and q.x-enemBullet.radius<player.x+player.width) and (player.y < q.y-enemBullet.radius and q.y-enemBullet.radius<player.y+player.height)) or 
		((player.x < q.x+enemBullet.radius and q.x+enemBullet.radius <player.x+player.width) and (player.y < q.y+enemBullet.radius and q.y+enemBullet.radius+player.height<player.y+enemy.height)) or 
		((player.x < q.x+enemBullet.radius and q.x+enemBullet.radius<player.x+player.width) and (player.y < q.y-enemBullet.radius and q.y-enemBullet.radius<player.y+player.height)) or 
		((player.x < q.x-enemBullet.radius and q.x-enemBullet.radius<player.x+player.width) and (player.y < q.y+enemBullet.radius and q.y+enemBullet.radius<player.y+player.height)) then 
			player.hurt()
			table.remove(enemBullet, n)
		elseif q.x < 0 or q.x > love.window.getWidth() or q.y<0 or q.y>love.window.getHeight() then
			table.remove(enemBullet, n)
		end 
	end 
end  



function ENEMBULLET_UPDATE(dt)
	enemBullet.update(dt)
	enemBullet.collition()
end 

function ENEMBULLET_DRAW()
	enemBullet.draw()
end 