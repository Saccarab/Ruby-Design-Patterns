require './planet.rb'

class RockyPlanet < Planet 
	def initialize(distance_from_star, bool, guid)
		#pass parameters to base class
		super(distance_from_star, bool, ("r" + guid.to_s)) #concatenate / cast to string
	end
end	

class GaseousPlanet < Planet
	def initialize(distance_from_star, bool, guid)
		super(distance_from_star, bool, ("g" + guid.to_s))
	end
end

class HabitablePlanet < Planet
	def initialize(distance_from_star, bool, guid)
		super(distance_from_star, bool, ("h" + guid.to_s))
	end
end