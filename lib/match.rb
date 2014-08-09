require 'securerandom'

class Match
	def initialize(team1, team2)
		@self_team = Team.new(team1)
		@opponent_team = Team.new(team2)
		intro
	end

	def intro
		puts "Hello and welcome to the beatiful contest between the two great teams #{@self_team.caps} and #{@opponent_team.caps}!"
		toss
	end

	def toss
		puts "Let's get to the toss!"
		SecureRandom.random_number(1000) >= 500? @self_team.toss_win : @opponent_team.toss_win
	end
end