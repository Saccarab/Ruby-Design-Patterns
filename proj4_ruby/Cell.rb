require_relative 'Anthill'
class Cell
	attr_accessor :hill, :ants, :food
	def initialize()

		@hill = nil
		@food = 0
		@ants = Array.new

	end

end
