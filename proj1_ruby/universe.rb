require './sub_stars.rb'
class Universe
	attr_accessor :univ, :dwarf_count, :giant_count, :medium_count, :dhabitable_count, :drocky_count, :dgaseous_count
	attr_accessor :mhabitable_count, :mgaseous_count, :mrocky_count ,:ghabitable_count, :grocky_count, :ggaseous_count
	attr_accessor :medium_life_count, :dwarf_life_count, :giant_life_count
	def initialize (initial_size)

		# Star Counts
		dwarf_count = 0
		giant_count = 0
		medium_count = 0

		# DWARF Star planet counts
		drocky_count = 0
		dgaseous_count = 0
		dhabitable_count = 0

		# GIANT Star planet counts
		grocky_count = 0
		ggaseous_count = 0
		ghabitable_count = 0

		# MEDIUM Star planet counts
		mrocky_count = 0
		mgaseous_count = 0
		mhabitable_count = 0

		# LIFE Star planet counts
		dwarf_life_count = 0
		giant_life_count = 0
		medium_life_count = 0

		@univ = Array.new()

		for i in 0...initial_size
			type = rand 3
			if type == 0 
				univ[i] = DwarfStar.new()
				drocky_count = drocky_count + univ[i].rocky_count #elegancy xD
				dgaseous_count = dgaseous_count + univ[i].gaseous_count
				dhabitable_count = dhabitable_count + univ[i].habitable_count
				dwarf_life_count = dwarf_life_count + univ[i].life_count
				dwarf_count = dwarf_count + 1
			elsif type == 1 
				univ[i] = GiantStar.new()
				grocky_count = grocky_count + univ[i].rocky_count
				ggaseous_count = ggaseous_count + univ[i].gaseous_count
				ghabitable_count = ghabitable_count + univ[i].habitable_count
				giant_life_count = giant_life_count + univ[i].life_count
				giant_count = giant_count + 1
			elsif type == 2 
				univ[i] = MediumStar.new()
				mrocky_count = mrocky_count + univ[i].rocky_count
				mgaseous_count = mgaseous_count + univ[i].gaseous_count
				mhabitable_count = mhabitable_count + univ[i].habitable_count
				medium_life_count = medium_life_count + univ[i].life_count
				medium_count = medium_count + 1
			else 
				puts "rip"
			end
		end

		@dwarf_count = dwarf_count
		@giant_count = giant_count
		@medium_count = medium_count
		@drocky_count = drocky_count
		@dgaseous_count = dgaseous_count
		@dhabitable_count = dhabitable_count
		@grocky_count = grocky_count
		@ggaseous_count = ggaseous_count
		@ghabitable_count = ghabitable_count
		@mrocky_count = mrocky_count
		@mgaseous_count = mgaseous_count
		@mhabitable_count = mhabitable_count
		@dwarf_life_count = dwarf_life_count
		@giant_life_count = giant_life_count
		@medium_life_count = medium_life_count

		coordinateValidator
	end

	def coordinateValidator ##check if duplicate coordinates exist

		coordinates = Array.new()
		for i in 0...univ.length
			coordinates[i] = univ[i].getCoords #load all star coords as 3 sized arrays into coordinates array
		end

		for i in 0...univ.length #outer loop
			for j in 0...univ.length # inner loop
				if j != i
					#if all 3 coords are equal
					if coordinates[i][0] == coordinates[j][0] && coordinates[i][1] == coordinates[j][1] && coordinates[i][2] == coordinates[j][2]
						univ[i].x_coords = univ[i].x_coords + 1 #increment x_coord of the duplicate star by 1
						puts "altered a star's coords due to duplicity"
					end
				end
			end
		end
	end

	def printUniverse #print function

		puts "#{dwarf_count} Dwarf Stars with: "  
		puts "\tRocky Planet Count: #{drocky_count}"
		puts "\tGaseous Planet Count: #{dgaseous_count}"
		puts "\tHabitable Planet Count: #{dhabitable_count}"
		puts "#{dwarf_life_count} Planets with intelligent life"

		puts "#{giant_count} Giant Stars with: "
		puts "\tRocky Planet Count: #{grocky_count}"
		puts "\tGaseous Planet Count: #{ggaseous_count}"
		puts "\tHabitable Planet Count: #{ghabitable_count}"
		puts "#{giant_life_count} Planets with intelligent life"

		puts "#{medium_count} Medium Stars with: "
		puts "\tRocky Planet Count: #{mrocky_count}"
		puts "\tGaseous Planet Count: #{mgaseous_count}"
		puts "\tHabitable Planet Count: #{mhabitable_count}"
		print "#{medium_life_count} Planets with intelligent life"
	end
end

def distance (arr1, arr2)
	return Math.sqrt(((arr1[0] - arr2[0])**2) + ((arr1[1] - arr2[1])**2) + ((arr1[2] - arr2[2])**2))
end

