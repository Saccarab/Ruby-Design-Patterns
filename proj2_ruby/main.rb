require_relative 'Audience.'
require_relative 'Gladiator'
require_relative 'PrinceArthas'
require_relative 'KingArthas'

def main
	glad = Gladiator.new()

	createAudience(glad, 10)

	puts "Choose your quest"
	puts "1- Prince Arthas"
	puts "2- King Arthas"

	choice = gets.to_i()


	if choice == 1
		event1 = PrinceArthas.new(glad)
	elsif choice == 2
		event1 = KingArthas.new(glad)
	else
		puts "Choice error!"
	end

	event1.sequence()

end

def createAudience(gladiator, audience_count)
	for i in 0...audience_count
		audience = Audience.new()
		gladiator.register(audience)
	end
end
main()