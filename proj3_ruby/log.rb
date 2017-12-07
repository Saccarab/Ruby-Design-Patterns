require 'singleton'

class Log
	attr_accessor :file

	include Singleton

	def initialize
		@file = File.new("log.txt","a")
	end

	def write(msg)
		openFile
		file.puts(msg)
		file.flush
	end

	def openFile
		file = File.open("log.txt","a")
	end

	def closeFile
		file.close()
	end

end