class Team
	#...
end

class Match
	#...
	def initialize(team1, team2)
		@team1 = team1
		@team2 = team2
	end
end

class Cricketer
	#...
end

class Batsman < Cricketer
	#...
end

class Bowler < Cricketer
	#...
end

class Fielder < Cricketer
	#...
end

class Stadium 
	#...
end

module Startup
	game = "Cricket I58"
	
	def introduce
		puts "Hello and welcome to #{game}."
		give_options
	end

	def give_options
		options = ["Play a Quick Game", "Create A Player", "Play a Tournament"]
		puts "\nWhat would you like to do today?"
		options.each_with_index { |option, index| puts "#{index + 1}: #{option}" }
		take_options
	end

	def take_options
		option = gets.to_i
		#remember to raise exception whenever input not an integer
		case option
		when 1
			play_game
		when 2
			create_a_player
		when 3
			play_a_tournament
		else
			puts "Please enter a valid option."
		end
	end
end

module GameInitiate
	# check for 2 teams loaded
	teams = Array.new 
	def select_team
		puts "Which team would you like to play with?"
		display_teams
	end

	def display_teams
		File.foreach("..\data\teams.txt") { |line| teams << line }
		teams.each_with_index { |team, index| puts "#{index + 1}: #{team}" }

	end
end
