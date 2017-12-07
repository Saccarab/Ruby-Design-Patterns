class Gladiator
	attr_reader :crowd
	attr_accessor :health
	attr_reader :strength, :speed, :intellect, :name

	def initialize() //
		@crowd = Array.new()

		puts "Choose your name"
		@name = gets.chomp()
		total_points = 20
		puts "Totalpoints to be assigned: 20"
		puts "Assign your points in respective order"
		puts "Strength, speed, intellect, health"
		point = Array.new()

		for i in 0...4
			point[i] = 0
		end

		i = 0

		while total_points > 0 && i < 4 #assign stats
			
			assign = gets.to_i()
			while assign < 0 #reprompt if negative
				puts 'stats cant be negative!'
				assign = gets.to_i()
			end

			if assign > total_points
				point[i] = total_points
			else
				point[i] = assign
			end

			total_points = total_points - assign
			i = i + 1
		end

		puts point
		@strength = point[0] #grab values from array
		@speed = point[1]
		@intellect = point[2]
		@health = point[3]

	end

	def register(audience)
		crowd << audience
	end

	def deRegister(audience)
		crowd.delete(audience)
	end

	def notify(event)
		for audience in crowd
			audience.update(event)
		end
	end
end
