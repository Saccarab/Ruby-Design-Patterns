class Planet
	attr_accessor :life, :distance_from_star, :planet_id
	def initialize(distance, bool, guid) #assign attributes
		@life = bool
		@distance_from_star = distance
		@planet_id = guid 

		if bool == true
			puts "Planet with guid #{guid} has intel life"
		end
	end
end