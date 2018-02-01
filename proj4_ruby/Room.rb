require_relative 'Ant'
require_relative 'Cell'
class Room
	attr_accessor :type
	def initialize(type)
		@type = type
	end
	def spawn(proc_hill, sp_type)
		# puts "#{sp_type} spawned on #{proc_hill.color}"

		if sp_type != type
			puts "cant create other type of ants than #{type}"
			return
		end

		temp = Ant.new(proc_hill, type, proc_hill.color)
		# puts type
		# puts "HERE HERE #{type}"
		proc_hill.food = proc_hill.food - 1
		proc_hill.total_count = proc_hill.total_count + 1

		if type == 1
			proc_hill.forager_count = proc_hill.forager_count + 1
		#override forager execute
		class << temp
			def execute	(food, hill)
				self.level_up
				hill.food = (hill.food + food * self.experience) /2
			end
		end
		temp.type = 1 ##runtime type set
		elsif type == 2
			temp.type = 2
			proc_hill.warrior_count = proc_hill.warrior_count + 1
			#override warrior execute
			class << temp
				def execute (enemy)
					if enemy.type == 1 and enemy.alive and self.alive #forager fight
						puts "warrior vs forager"
				   		death = rand 2
				   		if death == 1 #forager dies
				   			puts "forager dies on color #{enemy.color}"
				   			enemy.alive = false
							enemy.hill.total_count = enemy.hill.total_count - 1
						    enemy.hill.forager_count = enemy.hill.forager_count - 1
		   			 		return true
				   		else
				   			return false
		   		 		end
				   	else #warrior fight
				   		if enemy.alive and self.alive
					   		puts "warrior vs warrior"
					   		hit_power = rand self.experience*3
					   		enemy_hit_power = rand enemy.experience*3
					   		if hit_power > enemy_hit_power
					   			enemy.alive = false
					   			self.level_up()
								enemy.hill.total_count = enemy.hill.total_count - 1
								enemy.hill.warrior_count = enemy.hill.warrior_count - 1
					   			return true # won
					   		else
					   			self.alive = false
					   			enemy.level_up()
					   			self.hill.total_count = self.hill.total_count - 1
								self.hill.warrior_count = self.hill.warrior_count - 1
			   					return false # lost
			   		 		end
		   		 		end
		   	 		end
				end 
			end
		else
			#override builder execute
			type = 3
			proc_hill.builder_count = proc_hill.builder_count + 1
			class << temp
				def execute
					roomType = rand 3+1
				   	if roomType == 1 #forager
				   		self.hill.rooms.push(Room.new(1))
				    elsif roomType == 2 #warrior
				   		self.hill.rooms.push(Room.new(2))
				    else #builder
				   		self.hill.rooms.push(Room.new(3))
				   	end
					self.hill.total_count = self.hill.total_count - 1
					self.hill.food = self.hill.food - 1
					self.hill.builder_count = self.hill.builder_count - 1
					self.alive = false
				end
			end

		end
		proc_hill.ants.push(temp)
		return temp
	end
end
