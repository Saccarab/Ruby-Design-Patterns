require './sub_planets.rb'
require 'securerandom'

class Star ()
	attr_accessor :planets, :chance_of_life, :range_of_planets, :rocky_count, :gaseous_count
	attr_accessor :habitable_count, :life_count, :x_coords, :y_coords, :z_coords, :recharge
	def initialize (chance_of_life, range_of_planets, goldilocks_floor, goldilocks_roof, recharge)
		#star builder 

		@chance_of_life = chance_of_life
		@range_of_planets = range_of_planets
		@goldilocks_floor = goldilocks_floor
		@goldilocks_roof = goldilocks_roof

		@planets = Array.new() #new Array to hold planets within each star

		life_count = 0
		rocky_count = 0
		gaseous_count = 0
		habitable_count = 0

		for i in 0..range_of_planets
			type = rand 3
			distance_from_star = rand 0..300 # times 10 millions of miles
			id = SecureRandom.uuid #Ruby built in random id generator

			if type == 0 
				planets[i] = RockyPlanet.new(distance_from_star, false, id)
				rocky_count = rocky_count + 1
			elsif type == 1 
				planets[i] = GaseousPlanet.new(distance_from_star, false, id)
				gaseous_count = gaseous_count + 1
			elsif type == 2
				# if all life conditions match
				if (rand 0..10000) <= (chance_of_life * 10000) and distance_from_star > goldilocks_floor and distance_from_star < goldilocks_roof
				## let there be life
					planets[i] = HabitablePlanet.new(distance_from_star, true, id)
					life_count = life_count + 1
				else
					planets[i] = HabitablePlanet.new(distance_from_star, false, id)
				end
				habitable_count = habitable_count + 1
			else 
				puts "rip planeterino"
			end
		end

		@life_count = life_count
		@rocky_count = rocky_count
		@gaseous_count = gaseous_count
		@habitable_count = habitable_count
		
		@recharge = recharge
		@x_coords = rand 2**8..2**64
		@y_coords =	rand 2**8..2**64
		@z_coords = rand 2**8..2**64
	end

	def getCoords()
		temp_array = []
		temp_array[0] = x_coords
		temp_array[1] = y_coords
		temp_array[2] = z_coords
		return temp_array
	end

	def putCoords() #helper function to assist on testing
		puts self.x_coords
		puts self.y_coords
		puts self.z_coords
	end

	def distance(arr1, arr2) #returns distance between 2 arrays with length 3
		return Math.sqrt(((arr1[0] - arr2[0])**2) + ((arr1[1] - arr2[1])**2) + ((arr1[2] - arr2[2])**2))
	end
end


