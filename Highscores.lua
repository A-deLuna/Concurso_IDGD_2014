Highscores = {}
stringNumber = ""
function Highscores.check()
	local hs = ""
	io.input("Highscores.txt")
	love.graphics.print(hs, 500, 300)
	for line in io.lines("Highscores.txt") do 
		stringNumber = string.gsub(line, "\n", "")
		
		if player.scoreValue  > 0 then 
			hs = hs..stringNumber.."\n"
			break
		else 
			hs = hs..line
		end 
	end
	io.close()
	io.output("Highscores.txt")
	io.write(hs)
	io.flush ()
	io.close()
end 
function Highscores.print() 
	love.graphics.print(stringNumber, 400, 300)
end 

