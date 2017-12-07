require_relative 'Apiproxy'

class Battlenet < Apiproxy

	attr_accessor :request, :nextObj, :char, :realm
	def initialize(realm, char_name, logfile, cache, obj)
		@realm = realm
		@char = char_name
		@nextObj = obj
		@log = logfile
		@cache = cache
		battleNetApiKey = "b7pycu6727tfgrnzawp6sn5bxeerh92z" # Battle Net Api Key
		@request = "https://eu.api.battle.net/wow/character/" + realm + "/" + char_name + "?fields=achievements&locale=en_GB&apikey=" + battleNetApiKey;
		self.getJson(request, @log, @cache)
	end


	def parseJson(response, logfile, cache)
		#Actual action method of the decorator
		
		if response.class == Array
			puts "Character level: #{response[0]}\nCharacter honorable kills: #{response[1]}"
			logfile.write("** CACHED DATA  ** sCharacter level: #{response[0]} Character honorable kills: #{response[1].chomp()} written to log on #{self.class} request")	
		else
			self.putText()
			body = JSON.parse(response)
			first = "Character level: #{body['level']}"
			third = "Character honorable kills: #{body['totalHonorableKills']}"
			puts first
			puts third
			cache.write("#{self.class}:#{char}:#{realm}:#{body['level']}/#{body['totalHonorableKills']}\n")
			logfile.write("#{first} #{third} written to log on #{self.class} request")	
			#call next
		end
		nextObj.getJson(nextObj.request, logfile, cache)
	end

end


