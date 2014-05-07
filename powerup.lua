powerup={}
powerup.pUpTime = 50


function powerup.load()
	powerup.oneupicon = love.graphics.newImage("img/1up.png")
	powerup.rpgicon = love.graphics.newImage("img/rpg.png")
	powerup.revicon = love.graphics.newImage("img/revolver.png")
	powerup.murricaicon = love.graphics.newImage("img/murrica.png")
end

function powerup.draw()
	love.graphics.setColor(255,255,255)
	for i, v in ipairs(powerup) do 
		if (v.time>40 and math.floor(v.time) % 2 ==0) or v.time<40 then
			if v.type == 1 then 	
				love.graphics.draw(powerup.rpgicon,v.x, v.y,v.rot,1,1)
			elseif v.type == 2 then
				love.graphics.draw(powerup.murricaicon,v.x, v.y,v.rot,1,1)
			elseif v.type == 3 then
				love.graphics.draw(powerup.revicon,v.x, v.y,v.rot,1,1)
			elseif v.type == 4 then
				love.graphics.draw(powerup.oneupicon,v.x, v.y,v.rot,1,1)
			end
		end
	end
end

function powerup.spawn(x,y)
	local testnum = love.math.random(20)

	if testnum==3 then
		table.insert(powerup,{x=x, y=y, type=math.random(4), time=0, rot=love.math.random(100)})
	end
end

function powerup.pickup()
	for i, v in ipairs(powerup) do 
		if math.sqrt(math.pow(player.x+player.width/2-v.x+15/2,2)+math.pow(player.y+player.width/2-v.y+15/2,2)) < player.width/2 + 16 then
			if v.type ~= 4 then
				player.bullettype= v.type
			end
			if v.type == 1 then
				player.ammo=3
			elseif v.type == 2 then 
				player.ammo = 10
			elseif v.type == 3 then
			    player.ammo = 2
			elseif v.type == 4 and player.hp<5 then
				player.hp = player.hp+1
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