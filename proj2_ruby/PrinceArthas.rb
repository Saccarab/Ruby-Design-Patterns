require_relative 'Arena'

class PrinceArthas < Arena
	attr_accessor :gladiator

	def initialize(gladiator)
		@gladiator = gladiator
	end

	def battle()
		puts "-----------BATTLE-------------"
		puts "Guardian: Turn back, mortals. Death and darkness are all that await you in this forsaken vault.
Arthas: I doubt there is anything down here more terrifying than what we've faced already.
Guardian: Believe what you will, boy. You shall not pass.
Guardian: Turn away... before it's... too late.
Arthas: Still trying to protect the sword, are you?
Guardian: No... trying to protect you... from it.
Arthas: Behold, Muradin, our salvation, Frostmourne.
Muradin steps close to the altar and kneels to read...
Muradin Bronzebeard: Hold lad, There is an inscription on the dais. It's a warning. 
It says, 'Whomsoever takes up this blade shall wield power eternal. Just as the blade rends flesh, so must power scar the spirit.'
Oh, I should've known. The blade is cursed! Let's get the hell out of here!
Muradin backs away."

		puts
		puts "1 - So be it, Muradin. I'll go along with my old companion Light's Vengeance"
		puts "2 - I would gladly bear any curse to save my homeland."

		wepchoice = gets.to_i

		intellect = gladiator.intellect

		if wepchoice == 1 #pick weapon
			strength = gladiator.strength + 5
			speed = gladiator.speed - 2
			health = gladiator.health + 35
		else
			strength = gladiator.strength + 10
			speed = gladiator.speed + 6
			health = gladiator.health + 25
			intellect = gladiator.intellect - 10
		end


		hero = strength*2 + speed + intellect #hero stats value for this fight
		enemy = 15 + 10 + 10				  #enemy stat value

		puts "hero total #{hero}"
		puts "enemy total #{enemy}"

		puts "--------------------"
		
		enemy_health = 50

		while health > 0 && enemy_health > 0  #fight goes on

			enemy_hit = rand enemy
			hero_hit = rand hero

			puts "Your health: #{health}"
			puts "Mal'Ganis's health: #{enemy_health}"
			if enemy_hit >= hero_hit  #random value difference between hits is decremented
				health = health - (enemy_hit - hero_hit)
				gladiator.notify('harm')
				puts "----------------------"
				puts "hero got damaged #{enemy_hit - hero_hit}"
			else
				enemy_health = enemy_health - (hero_hit - enemy_hit)
				puts "----------------------"
				puts "enemy got damaged #{hero_hit-enemy_hit}"
			end

		end

		if health <= 0 #battle lost
			puts "Pathetic Human..."
			puts "You died."
			gladiator.notify('taskfail')
			return 0
		end

		if enemy_health <= 0 #battle won
			puts " Mal'Ganis: So, you've taken up Frostmourne at the expense of your comrades' lives, just as the Dark Lord said you would. You're stronger than I thought.
Arthas: You waste your breath Mal'Ganis. I heed only the voice of Frostmourne now.
Mal'Ganis: You hear the voice of the Dark Lord. He whispers to you through the blade you wield... What does he say, young human? What does the Dark Lord of the Dead tell you now?
Arthas: He tells me the time for my vengeance has come.
Mal'Ganis: What? He couldn't possibly mean to--
Arthas: It is finished"
			gladiator.notify('taskdone')
			return 1
		end

	end

	def riddle()
		puts
		puts "-----------RIDDLE-------------"

		riddle_count = 3 - gladiator.intellect/7
		riddle = Array.new()

		riddle[0] = Array.new()
		riddle[0][1] = 2 #answer
		riddle[0][0] = "When we first meet, I may seem strong 
But at the end of the day, you will be wrong 
After killing many a croc, you will discover 
There is nothing but a medallion to recover 
After shedding tears from a truth so grim 
I will give you the cloak I was going to give him.
	1 - Thrall
	2 - Misha Tor'kren
	3 - Garrosh"
		#Misha Tor'kren

		riddle[1] = Array.new()
		riddle[1][1] = 1 #answer
		riddle[1][0] = 'Worm meat you gather when we first meet. 
Since then many other tasks you had to complete. 
My grand quest is finally done. 
I now wander the halls of my late son.
	1 - Tirion Fordring
	2 - Bolvar Fordragon
	3 - Uther Lightbringer'
		#Tirion Fordring

		riddle[2] = Array.new()
		riddle[2][1] = 1 #answer
		riddle[2][0] = 'Eternal Jailor was the title bestowed upon me 
After that I was prisoner for a while 
But now I understand when they say 
The hunter is nothing without a prey.
	1 - Maiev Shadowsong
	2 - Cordana Felsong
	3 - Naisha'
		#Maiev Shadowsong

	correct_answers = 0;

		for i in 0...riddle_count
			correct_answers = correct_answers + riddleHelper(riddle[i][0], riddle[i][1]) #riddle helper
		end

		if (correct_answers == riddle_count)
			puts "You passed my riddle challenge"
			gladiator.notify('taskdone')
		else
			puts "You failed the riddle test"
			gladiator.notify('taskfail')
		end

	end


	def agility()
		puts
		puts "-----------SPEED-------------"

		m = 0;
		time = Time.now.to_i  #initial timer
		count = 6 - gladiator.speed / 4
		puts "You have to type jaina #{count} times in 7 seconds"

		while (m != count && ((Time.now.to_i - time) < 7))
			hold = gets.strip
			if hold == "jaina"
				puts "Correct!"
				m = m + 1
			end
		end

		dif = Time.now.to_i - time  #
		puts "you answered in #{dif} seconds"
		if (dif > 7) #takes longer than 10 secs
			puts "You failed the speed test"
			gladiator.notify('taskfail')
		else
			puts "You passed the speed test	"
			gladiator.notify('taskdone')
		end
	end
end
