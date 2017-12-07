require './star.rb'

class DwarfStar < Star
	def initialize
		planet_range = rand 8..16 #assign attributes
		goldi_bot = 30
		goldi_top = 90
		super(0.0006, planet_range, goldi_bot, goldi_top, 2**20) #add chance_of_life aw to subclasses
	end
end	

class GiantStar < Star
	def initialize
		planet_range = rand 5..11
		goldi_bot = 100
		goldi_top = 250
		super(0.0005, planet_range, goldi_bot, goldi_top, 2**30)
	end
end

class MediumStar < Star
	def initialize
		planet_range = rand 2..10
		goldi_bot = 60
		goldi_top = 140
		super(0.0009, planet_range, goldi_bot, goldi_top, 2**25)
	end
end
