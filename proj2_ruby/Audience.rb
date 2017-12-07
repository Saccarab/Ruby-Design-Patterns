require_relative 'Response'

class Audience
	attr_accessor :strategy

	def initialize()
		type = rand 3 #random response

		if type == 0 
			@strategy = PositiveResponse.new()
		elsif type == 1 
			@strategy = NegativeResponse.new()
		elsif type == 2
			@strategy = NeutralResponse.new()
		end
	end

	def update(event)

		if event == 'harm'
			strategy.harm()
		elsif
			event == 'taskdone'
			strategy.taskDone()
		elsif 
			event == 'taskfail'
			strategy.taskFail()
		else
			puts 'event handling fail!'
		end

	end

end
