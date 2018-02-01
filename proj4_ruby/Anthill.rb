require_relative 'Ant'
require_relative 'Room'
class Anthill
	attr_accessor :strategy, :color, :rooms, :total_count, :forager_count, :builder_count, :warrior_count, :x_coords, :y_coords, :ants,:food, :alive
	def initialize()
		@alive = true
		@food = 7
		@rooms = Array.new()
		@ants = Array.new()
		@x_coords = nil ##
	    @forager_count = 0
	    @warrior_count = 0
	    @builder_count = 0
		@y_coords = nil ##
		@strategy = strategy ##
		@color = nil #1 red #2 blue #3 yellow #4 green ##
		@total_count = 0
	end

	def anthill_destroy
		self.alive = false
		for i in 0...ants.length
			ants[i].alive = false
		end
	end
end
