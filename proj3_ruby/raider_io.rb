require_relative 'Apiproxy'

class Raider_io < Apiproxy

	attr_accessor :request, :nextObj, :char, :realm
	def initialize(realm, char_name, obj)	
		@realm = realm
		@char = char_name
		@nextObj = obj
		@request = "https://raider.io/api/v1/characters/profile?region=EU&realm=" + realm  + "&name=" + char_name + "&fields=gear"
	end


	def parseJson(response, logfile, cache)

		#Actual action method of the decorator
		
		if response.class == Array
			puts "Character class: #{response[0]}"
			puts "Character specialization: #{response[1]}"
			logfile.write("** CACHED DATA  ** Character class: #{response[0]} Character specialization: #{response[1].chomp()} written to log on #{self.class} request")	
		else
			self.putText()
			body = JSON.parse(response)
			first = "Character class: #{body['class']}"
			second = "Character specialization: #{body['active_spec_name']}"
			puts first
			puts second

			cache.write("#{self.class}:#{char}:#{realm}:#{body['class']}/#{body['active_spec_name']}\n")
			logfile.write("#{first} #{second} written to log on #{self.class} request")
			#call nextObj
		end
		nextObj.getJson(nextObj.request, logfile, cache)
	end

end


