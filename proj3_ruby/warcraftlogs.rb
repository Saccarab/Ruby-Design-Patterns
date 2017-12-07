require_relative 'Apiproxy'

class Warcraftlogs < Apiproxy

	attr_accessor :request, :char, :realm
	def initialize(realm, char_name)
		@realm = realm
		@char = char_name
		warcraftLogsApiKey = "bff965ef8c377f175a671dacdbdbc822"
		@request = "https://www.warcraftlogs.com/v1/rankings/character/" + char_name + "/" + realm + "/EU?api_key=" + warcraftLogsApiKey
	end

	def parseJson(response, logfile, cache)
		# if response.class == Array
		#Actual action method of the decorator
		if response.class == Array ##if response is an array an not a json means we got a cache
			puts "Ranked #{response[1]} out of #{response[2].chomp()} in encounter number #{response[0]}"
			logfile.write("** CACHED DATA  ** Ranked #{response[1]} out of #{response[2].chomp()} in encounter number #{response[0]} written to log on #{self.class} request")	
		else
			self.putText()
			body = JSON.parse(response)
			first = body[0]["encounter"]
			second = body[0]["rank"]
			third = body[0]["outOf"]
			puts "Ranked #{second} out of #{third} in encounter number #{first}"

			cache.write("#{self.class}:#{char}:#{realm}:#{first}/#{second}/#{third}\n")
			logfile.write("Ranked #{second} out of #{third} in encounter number #{first} written to log on #{self.class} request")	
		end
	end

	#cover to the last element errors in the decorator
	def method_missing(m, *args, &block)  
	    puts "End of line!"  
	end

end

