require 'singleton'
require 'colorize'
require_relative 'Cell'
require_relative 'Queen'

class Meadow
	attr_accessor :grid, :temp_hill_array
	include Singleton
	def initialize()
		@temp_hill_array = Array.new()
		@grid=Array.new(15){Array.new(15)}
		for j in 0..14
			for i in 0..14
				grid[j][i]=Cell.new()
			end
		end
	end

	#-------------------- BUILDER PATTERN CALLS
	def fill
		anthill_count = 0
		while anthill_count < 4
			queen = Queen.new(anthill_count+1)
			new_anthill=queen.setAnthill.location.setColor.defineStrategy.buildAnthill
			temp_hill_array.push(new_anthill)
			anthill_count = anthill_count + 1
			grid[new_anthill.x_coords][new_anthill.y_coords].hill = new_anthill # set anthill ?
			new_anthill.rooms.push(Room.new(1))	#forager room
			new_anthill.rooms.push(Room.new(2))	#warrior room
			new_anthill.rooms.push(Room.new(3)) #builder room
			spawn_type = new_anthill.strategy.decide(new_anthill)
			new_anthill.rooms[spawn_type - 1].spawn(new_anthill, spawn_type) #redundant
		end
	end

	def Simulation
		fill
		process = true
		anthill_count = 4
		while anthill_count > 1
			system "cls"
			for j in 0..14
				for i in 0..14
					##--------------- generate food------------
					generatefood = rand 17
					if generatefood == 1 #lucky number to generate food
						foodCount = rand 2
						grid[j][i].food = grid[j][i].food + foodCount
					end
					if grid[j][i].hill
						temp_hill = grid[j][i].hill
						##-----------------builder ant actions --------------
						for l in 0...temp_hill.ants.length
							if temp_hill.ants[l].type == 3 && temp_hill.ants[l].alive = true and temp_hill.rooms.length <= 14 #builder
								if temp_hill.rooms.length == temp_hill.total_count or temp_hill.rooms.length - 1 == temp_hill.total_count and temp_hill.food > 2
									temp_hill.ants[l].execute ##builder action
								end
							end
						end
						##------------------ spawn non existant Ants
						while temp_hill.total_count < temp_hill.rooms.length && temp_hill.food >= 1 and temp_hill.total_count <= 15
							spawn_type = temp_hill.strategy.decide(temp_hill)
							t_ant = temp_hill.rooms[spawn_type - 1].spawn(temp_hill, spawn_type) #redundant
							if t_ant.type != 3
								grid[j][i].ants.push(t_ant)
							end

							#append to cell??
						end
					end

					#-1-2-3-4-5-6
					#-1-2-3-4

					##----------------- ant actions --------------
					o = 0
					while o < grid[j][i].ants.length
						#move

						if grid[j][i].ants[o]
							tt = grid[j][i].ants[o]
							ant = tt.clone()
							ant.move
							x_c = ant.x_coords
							y_c = ant.y_coords
							grid[x_c][y_c].ants.push(ant)
							grid[j][i].ants.delete_at(o)

							#*************************forager********************
							if ant.type == 1 and grid[x_c][y_c].food > 0 #forager
								ant.execute(grid[x_c][y_c].food, ant.hill)
								grid[x_c][y_c].food = 0
							end

							## ---------------------------- ANT VERSUS HILL
							if ant.type == 2 and grid[x_c][y_c].hill == true and ant.color != grid[x_c][y_c].hill.color #warrior
								destroy = 10
								##calculate experience?
								if destroy == 1 #warrior ant is victorious over the anthill!
									grid[x_c][y_c].hill.anthill_destroy #hill destroyer
									puts "destroyed a hill"
									grid[x_c][y_c].hill = nil
									anthill_count = anthill_count - 1
									#destroy grid[x_c][y_c].hill and every single ant within
								end
							end

							tmp_length = grid[x_c][y_c].ants.length

							#WARRIOR ACTIONS

							if tmp_length >= 2 and ant.type == 2  #warrior
								#tmp_length - 1 is our ant!
								#so iterate below looking for an alive enemy ant
								q = tmp_length - 2
								while q >= 0
									if grid[x_c][y_c].ants[q].alive and grid[x_c][y_c].ants[q].color != ant.color
							    		enemy = grid[x_c][y_c].ants[q] #set enemy
									    if enemy.type == 2 #enemy warrior
											if ant.execute(enemy) #enemy ant as parameter
												grid[x_c][y_c].ants.delete_at(q)
											end
										elsif enemy.type == 1 # enemy forager
											#warrior vs forager
											if ant.execute(enemy)
												grid[x_c][y_c].ants.delete_at(q)
											end
										else
											#pass
										end
										break
									else
										q = q - 1
									end
								end
							end
						end
					end
				end

			end
			anthill_count = self.disp(anthill_count)			
		end
	end

	def disp(anthill_count)
		for j in 0..14
			for z in 0..12*15
				print '_'.colorize(:background => :white)
			end
			puts ""
			for i in 0..14
				check=false
				k=0
				while(k<12)
					if(k == 0)
						print '|'.colorize(:color => :black)
					elsif (k==6 && grid[j][i].hill)
						setColor('#',grid[j][i].hill.color)
					elsif k>6&&grid[j][i].ants.length!=0&&!check
						deadcount=0
						for y in 0.. grid[j][i].ants.length-1
							if(!grid[j][i].ants[y].alive)
								deadcount+=1
							end
							if(grid[j][i].ants[y].type==1 and grid[j][i].ants[y].alive)
					 			setColor("~",grid[j][i].ants[y].color)
					 		end
					 		if(grid[j][i].ants[y].type==2 and grid[j][i].ants[y].alive)
					 			setColor("^",grid[j][i].ants[y].color)
					 		end
						end
							check=true

						 	k = k + grid[j][i].ants.length-1-deadcount

					else
						print " ".colorize(:background => :white)
					end
					k=k+1
				end
			end
			print "|"
			puts " "
		end
		for z in 0..12*15
			print '_'
		end
		for i in 0...temp_hill_array.length
			if temp_hill_array[i].alive
				if temp_hill_array[i].forager_count == 0 && temp_hill_array[i].food == 0
					temp_hill_array[i].anthill_destroy
					grid[temp_hill_array[i].x_coords][temp_hill_array[i].y_coords].hill = nil
					anthill_count = anthill_count - 1
				else
					puts
					puts "=======Anthill #{i}======="
					puts "Alive Count: #{temp_hill_array[i].total_count} Food: #{temp_hill_array[i].food} Rooms: #{temp_hill_array[i].rooms.length} Warrior: #{temp_hill_array[i].warrior_count} Foragers: #{temp_hill_array[i].forager_count} Builders #{temp_hill_array[i].builder_count}"
				end
			end
		end
		return anthill_count
	end

	def destroyHill(hill)
		for z in 0...hill.ants.length
			hill.ants[z].alive = false
			hill.total_count = 0
			hill.builder_count = 0
			hill.forager_count = 0
			hill.warrior_count = 0
		end

	end

	def setColor(str,color) #1 red #2 blue #3 yellow #4 green

		if(color==1)
			print str.colorize(:red).colorize(:background => :white)
		elsif color==2
			print str.colorize(:blue).colorize(:background => :white)
		elsif color==3
			print str.colorize(:yellow).colorize(:background => :white)
		else
			print str.colorize(:green).colorize(:background => :white)
		end
	end
end
