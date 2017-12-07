require 'open-uri'
require 'json'

class Apiproxy

	def initialize()
		raise NotImplementedError
	end

	def okay(reg) ##cache file search
		File.open("cache.txt") do |f|
	  		f.each_line do |line|
			    if line =~ /#{reg}/
			    	return "#{line}"
			    end
			end
		end
	end

	def getJson(url, logfile, cache)

		found = false
		type = self.class

		regex = "#{self.class}:#{self.char}:#{self.realm}"
		temp = okay(regex)
		#cached!!
		if (temp.class == String)
			puts "#{type}"
			found = true
			a = temp.split(":")
			if type == Battlenet
				query = a[3].split('/')
				parseJson(query, logfile, cache)
			elsif type == Raider_io
				query = a[3].split('/')
				parseJson(query, logfile, cache)
			elsif type == Warcraftlogs
				query = a[3].split('/')
				parseJson(query, logfile, cache)

			else
				
			end
		end

		if (!found)
			#parse url
			encoded_url = URI.encode(url)
			request_url = URI.parse(encoded_url)

			#error handling
			begin 
				request = open(request_url)
			rescue SocketError, OpenURI::HTTPError => e
				puts "Connection error #{e.message} for #{self.class} request"
			end

			#handle error message
			if e && ((e.message.include? "connection") || (e.message.include? "404") || (e.message.include? "400")) 
				if self.nextObj
					logfile.write(e.message)
					self.nextObj.getJson(nextObj.request, logfile, cache)
				else
					logfile.write(e.message)
				end
			else
				if !(request.nil?)
					content = request.read
					resp = parseJson(content, logfile, cache)
				end
			end
		end
	end

	def putText()
		puts "Data Requested from " + self.class.name + " API."
	end

	def parseJson()
		raise NotImplementedError
	end

end
