class PositiveResponse
	def harm
		puts "boo"
	end

	def taskDone
		puts "cheers"
	end

	def taskFail
		puts "gasps"
	end
end

class NegativeResponse
	def harm
		puts "cheers"
	end

	def taskDone
		puts "boos"
	end

	def taskFail
		puts "cheers"
	end
end

class NeutralResponse
	def harm
		puts "shakes head :smh"
	end

	def taskDone
		puts "applauds"
	end

	def taskFail
		puts "grabs popcorn"
	end
end