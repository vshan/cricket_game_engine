class Team

	attr_accessor :name_of_team
	attr_reader :team_id
	
	def initialize(team)
		@team_id = team
		load(@team_id)
	end

	@no_of_players_in_team = 11

	def name_of_team
		
	end

	def load(team)
		
	end

end