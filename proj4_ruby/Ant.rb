class Ant
	attr_accessor :x_coords, :y_coords, :type, :color, :hill, :experience, :alive

	def initialize(hill, type, color)
		@type = type
		@color = color
		@hill = hill
		@x_coords = hill.x_coords
		@y_coords = hill.y_coords
		@experience = 1
		@alive = true
	end

	def clone_ant(ant)
		temp = Ant.new(ant.proc_hill, ant.type, ant.proc_hill.color)
		clone = ant.clone
	end

	def level_up()
		@experience = @experience + 1
	end

	def execute
	end
	
	def move
		dim = rand 2 #0 for x_dimension
						 #1 for y_dimension

		vektor = rand 2 #0 for coords + 1
							 #1 for coords - 1

		if dim == 0 #x_dimension
			if vektor == 0
				if x_coords == 14 # cant move further above
					@x_coords = x_coords - 1
				else
					@x_coords = x_coords + 1
				end
			else #vektor == 1
				if x_coords == 0 # cant move further down
					@x_coords = x_coords + 1
				else
					@x_coords = x_coords - 1
				end
			end
		else # dim == 1 y_dimension
			if vektor == 0
				if y_coords == 14 # cant move further above
					@y_coords = y_coords - 1
				else
					@y_coords = y_coords + 1
				end
			else #vektor == 1
				if y_coords == 0 # cant move further above
					@y_coords = y_coords + 1
				else
					@y_coords = y_coords - 1
				end
			end
		end
	end #end move function
end #end class ant
