explosion = {}
explosion.radius = 50
explosion.timer = 1


function explosion.spawn(x, y)
	table.insert(explosion, {x=x, y=y, time = 0, indivRadius = 0})
end

function explosionUpdate(v, dt)
	v.indivRadius = v.indivRadius + 50*dt
	if v.time <= 1 then
		v.time=v.time+dt
	else
	    v=nil
	end
end

function explosionDraw(v)
	local colory=math.random(225)
	love.graphics.setColor(colory+30,colory,0)
	love.graphics.circle("fill",v.x,v.y,v.indivRadius)
end

function explosion.update(dt)
	for i,v in ipairs(explosion) do 
		explosionUpdate(v, dt)
		if v.time>=explosion.timer then
			table.remove(explosion, i)
		end
	end
	explosion.collision()
end

function explosion.draw()
	for i,v in ipairs(explosion) do 
		explosionDraw(v)
	end
end

function explosion.collision()
	for p,q in ipairs(explosion) do
		for i,v in ipairs(enemy) do 
			if math.sqrt((((v.x+enemy.width/2)-q.x)^2)+(((v.x+enemy.height/2)-q.y)^2))<(enemy.width/2)+q.indivRadius then 
				powerup.spawn(v.x, v.y)
				enemy[i]=nil
			end 
		end 
		--if math.sqrt(math.pow((player.x+player.width/2)-q.x, 2)+math.pow((player.y+player.height/2)-q.y,2))<(player.width/2)+q.indivRadius and not player.invincible then 
		--	player.hp = player.hp -1
		--	player.invTimer = 0
		--	player.invincible = true
		--end 
	end
end