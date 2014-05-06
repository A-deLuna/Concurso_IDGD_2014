powerup={}
powerup.pUpTime = 50

function powerup.draw()
	for i, v in ipairs(powerup) do 
		if (v.time>40 and math.floor(v.time) % 2 ==0) or v.time<40 then
			if v.type == 1 then 	
				love.graphics.setColor(255,255,255)
				love.graphics.polygon("fill",v.x,v.y,v.x+15,v.y,v.x+15/2,v.y-15)
			elseif v.type == 2 then
				love.graphics.setColor(255,0,0)
				love.graphics.polygon("fill",v.x,v.y,v.x+15,v.y,v.x+15/2,v.y-15)
			elseif v.type == 3 then
				love.graphics.setColor(175,100,255)
				love.graphics.polygon("fill",v.x,v.y,v.x+15,v.y,v.x+15/2,v.y-15)
			end
		end
	end
end

function powerup.spawn(x,y)
	local testnum = love.math.random(5)

	if testnum==3 then
		table.insert(powerup,{x=x, y=y, type=math.random(3), time=0})
	end
end

function powerup.pickup()
	for i, v in ipairs(powerup) do 
		if math.sqrt(math.pow(player.x+player.width/2-v.x+15/2,2)+math.pow(player.y+player.width/2-v.y+15/2,2)) < player.width/2 + 15/2 then
			player.bullettype= v.type
			player.ammo=3
			if v.type ~= 1 then 
				player.ammo = 10
			end 
			table.remove(powerup,i)
		end
	end
end

function powerup.removal(dt)
	for i, v in ipairs(powerup) do
		if v.time > powerup.pUpTime then
			table.remove(powerup, i)
		else
		    v.time= v.time +5*dt
		end
	end
end

function POWERUP_UPDATE(dt)
	powerup.pickup()
	powerup.removal(dt)
end