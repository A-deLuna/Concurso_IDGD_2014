Highscores = {}

function Highscores.check()

	local f = io.open("Highscores.txt","r")
	--love.graphics.print(hs, 500, 300)
	n1,n2,n3,n4,n5 = f:read("*number","*number","*number","*number","*number")
		
	if player.scoreValue > 	n1 then 
		n5 = n4
		n4 = n3
		n3 = n2
		n2 = n1
		n1 = player.scoreValue
	elseif player.scoreValue > n2 then 
		n5 = n4
		n4 = n3
		n3 = n2
		n2 = player.scoreValue
	elseif player.scoreValue > n3 then
		n5 = n4
		n4 = n3
		n3 = player.scoreValue
	elseif player.scoreValue > n4 then 
		n5 = n4
		n4 = player.scoreValue
	elseif player.scoreValue > n5 then 
		n5 = player.scoreValue
	end 
		
	
	io.close(f)
	k = io.open("Highscores.txt", "w")
	k:write(n1," ",n2," ",n3," ",n4," ",n5)
	io.flush()
	io.close(k)
end 
function Highscores.print() 
	--	love.graphics.print(, 400, 300)
end 

