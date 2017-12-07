class Arena
	def initialize(gladiator)
		raise NotImplementedError
	end

	def sequence()
		if battle() == 1 #if battle is won
			riddle()
			agility()
		end
	end

	def battle
		raise NotImplementedError
	end

	def riddle
		raise NotImplementedError
	end

	def agility
		raise NotImplementedError
	end

	def riddleHelper(riddle, answer) #riddle helper to manage riddles array
		puts riddle
		x = gets.to_i
		if (x == answer)
			puts "okay.. you got this one right"
			return 1
		else
			puts "Not today I suppose."
			return 0
		end
		puts
	end
end