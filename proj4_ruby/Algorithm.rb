class Aggressive
	def decide(hill)
		if hill.builder_count == 0
			return 3 # builder
		elsif
			hill.forager_count >= 2 and hill.rooms.length > hill.total_count
			return 2 # warrior
		else
		   return 1 # forager
		end
	end
end

class Economy
	def decide(hill)
		if hill.builder_count == 0
			return 3 # builder	
		elsif hill.forager_count > 5
			return 2 # warrior
		else
			return 1 # forager
			
		end
	end
end

class Growth
	def decide(hill)
		if hill.builder_count == 0
			return 3 #builder
		elsif hill.forager_count >= 3 && hill.rooms.length == 15
			return 2 #warrior
		else
			return 1 #forager
		end
	end
end
