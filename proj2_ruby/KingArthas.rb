require_relative 'Arena'

class KingArthas < Arena
	attr_accessor :gladiator

	def initialize(gladiator)
		@gladiator = gladiator
	end

	def battle()
		puts "Uther the Lightbringer: Your father ruled this land for seventy years, and you've ground it to dust in a matter of days.
Arthas: Very dramatic, Uther. Give me the urn, and I'll make sure you die quickly.
Uther the Lightbringer: The urn holds your father's ashes, Arthas! What, were you hoping to piss on them one last time before you left this kingdom to rot?
Arthas: I didn't know what it held. Nor does it matter. I'll tell whatever I came for one way or another."
		puts
		puts "1 - Guidance of Kel'thuzad"
		puts "2 - Guidance of Tichondrious"

		wep_choice = gets.to_i
		intellect = gladiator.intellect
		strength = gladiator.strength
		speed = gladiator.speed
		health = gladiator.health

		if wep_choice == 1 #pick weapon
			intellect = intellect + 7
			speed = speed + 1
			health = health + 15
		elsif wep_choice == 2
			strength = strength + 6
			speed = speed + 4
			intellect = intellect - 5
			health = health + 20
		else
			puts "weapon choice error"
		end

		hero = strength + speed*2 + intellect
		enemy = 28

		puts "hero total #{hero}"
		puts "enemy total #{enemy}"

		puts "--------------------"

		enemy_health = 30
 
		while health > 0 && enemy_health > 0 #battle while both targets are alive
			enemy_hit = rand enemy
			hero_hit = rand hero

			puts "Your health: #{health}"
			puts "Uther's health #{enemy_health}"
			if enemy_hit >= hero_hit
				health = health - (enemy_hit - hero_hit)
				gladiator.notify('harm')
				puts "----------------------"
				puts "hero got damaged #{enemy_hit-hero_hit}"
			else
				enemy_health = enemy_health - (hero_hit - enemy_hit)
				puts "----------------------"
				puts "you hit Uther for #{hero_hit-enemy_hit}"
			end
		end

		if health <= 0 #fight lost
			puts "I'm glad you'll be rotting in hell Arthas."
			gladiator.notify('taskfail')
			return 0
		end

		if enemy_health <= 0 #fight won
			puts "Uther the Lightbringer: I dearly hope that there's a special place in hell waiting for you, Arthas.
Arthas: We may never know, Uther. I intend to live forever."
			gladiator.notify('taskdone')
			return 1
		end
	end

	def riddle

		puts
		puts "-----------RIDDLE-------------"

		riddle_count = 3 - gladiator.intellect/7
		riddle = Array.new()

		riddle[0] = Array.new()
		riddle[0][1] = 2 #answer
		riddle[0][0] = 'Deep within the earth is where I reside 
Many walk me with pride 
Too soon, is my usual complain 
Maybe this time my preperation wont be in vain.
	1 - Deathwing
	2 - Ragnaros
	3 - The Lich King'
		#Ragnaros

		riddle[1] = Array.new()
		riddle[1][1] = 3 #answer
		riddle[1][0] = 'Long, long ago, we were pure. 
In time, we became insane. 
We fought with zeal. 
Truth to be told, we were ruled by those who we sought to destroy.
	1 - Night Elves
	2 - Orcs
	3 - The Highborne'
		#the highborne

		riddle[2] = Array.new()
		riddle[2][1] = 2 #answer
		riddle[2][0] = 'Forgotten by time and heros of good
For I have for thusands years here stood
Now I revenge the queen from a glorious age
My enemy, I hunger to darken your dream Stormrage!
	1 - Cenarius
	2 - Ursoc
	3 - Illidan'
		#xavius

		correct_answers = 0;

		for i in 0...riddle_count #riddle helper iterate over riddle array
			correct_answers = correct_answers + riddleHelper(riddle[i][0], riddle[i][1])
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
		time = Time.now.to_i 
		count = 6 - gladiator.speed / 4 #speed expression
		puts "You have to type nerzhul #{count} times in 10 seconds"

		while (m != count && ((Time.now.to_i - time) < 10))
			hold = gets.strip
			if hold == "nerzhul"
				puts "Correct!"
				m = m + 1
			end
		end

		dif = Time.now.to_i - time 
		puts "you answered in #{dif} seconds"
		if (dif > 10)
			puts "You failed the speed test"
			gladiator.notify('taskfail')
		else
			puts "You passed the speed test	"
			gladiator.notify('taskdone')
		end
	end
end