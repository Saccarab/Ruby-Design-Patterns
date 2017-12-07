require 'singleton'

class Cache
	attr_accessor :file

	include Singleton

	def initialize
		@file = File.new("cache.txt","a")
	end

	def write(msg)
		openFile
		file.puts(msg)
		file.flush
	end

	def openFile
		file = File.open("cache.txt","a")
	end

	def closeFile
		file.close()
	end

end