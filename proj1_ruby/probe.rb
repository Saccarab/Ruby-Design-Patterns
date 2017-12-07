class Probe

	FUEL_MULTIPLIER = 70 #constant that calculates fuel consumption rate depending on distance
	attr_accessor :stars_to_travel, :travel_route, :index, :current_coords, :starting_coords, :univ
	attr_accessor :visited_stars, :visited_planets, :fuel, :not_life, :total_distance

	def initialize(star_array)

		@fuel = 2**64
		@visited_planets = 0
		@total_distance = 0
		@univ = star_array
		
		x = rand (2**8..2**64)
		y = rand (2**8..2**64)
		z = rand (2**8..2**64)
		@starting_coords = [x, y ,z]

		puts "Your origin was #{starting_coords}"

		@visited_stars = 0
		@current_coords = starting_coords
		@index = Array.new()
		@not_life = false

	end

	def printDetails #prints probe findings 

		if fuel < 0
			puts "\tOut of fuel!"
		end

		if univ.length < 2
			puts "\tCouldnt find any life"
		end

		puts "\tRemaining fuel is #{fuel}"
		puts "\tVisited #{visited_stars} stars"
		puts "\tVisited #{visited_planets} planets"
		puts "\tTotal distance traveled is #{total_distance}"
	end

	def updateCurrent() #updates probe's route depending on current coordinates

		for i in 0..univ.length - 1
			arr = univ[i].getCoords
			index[i] = [distance(arr, current_coords), i] 
			# 2 sized arrays inside the index array in following format
			# -> index[distanceToCurrent, givenStar's index in the main array]
		end

		index.sort! do |a, b| #sort's index array by it's first argument which is distance to current coords
			a[0] <=> b[0]
		end
	end

	def search()

		while (!not_life && fuel > 0 && univ.length > 1) #while conditions are set
			move()
		end

		printDetails
		
	end

	def move() 

		updateCurrent() #update route relative to current coordinates

		@visited_stars = @visited_stars + 1

		next_star_index = index[0][1] #first element on the index array is the closest next star
									  #and index[0][1] holds the relative main array index

		size = univ[next_star_index].planets.length #planet count in the next star

		@visited_planets = @visited_planets + size

		distance = (index[0][0]).round  #distance is actually

		fuel_consumed = distance / FUEL_MULTIPLIER

		@fuel = @fuel - fuel_consumed
		@fuel = @fuel + univ[next_star_index].recharge

		@total_distance = @total_distance + distance

		for i in 0..size - 1
			if (univ[next_star_index].planets[i].life) #if there is life
				puts "\tFound life on planet #{univ[next_star_index].planets[i].planet_id}"
				@not_life = true
				backHome()
			end
		end

		@current_coords = univ[next_star_index].getCoords

		univ.delete_at(next_star_index) #remove the visited star from universe array
										#so that wont interfere on route array later on

		index.delete_at(0)				#shrink index array to keep index.length expressions healthy

	end

	def backHome #return home to starting point

		return_home = distance(current_coords, starting_coords)
		@fuel = @fuel - return_home / FUEL_MULTIPLIER
		@total_distance = @total_distance + return_home
	end
end