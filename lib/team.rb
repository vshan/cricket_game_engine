class Team
  attr_accessor :name_of_team
  attr_reader :team_id

  NO_OF_PLAYERS_IN_TEAM = 11
  @@teams = take_options_from_file_return_array("../data/teams.txt")
  
  def initialize(team, team_type)
    @team_id = team
    @team_type = team_type
    set_name_of_team(@team_id)
    load(@team_id)
  end

  def set_name_of_team(id)
    @name_of_team = @@teams[id-1]
  end

  def load(team)
    @team_players = []
    for i in 0...NO_OF_PLAYERS_IN_TEAM
      @team_players[i] = Player.new(@name_of_team)
    end
    i = 0
    CSV.foreach("../data/#{@name_of_team.downcase}_cricket_team", headers: true, converters: :numeric) do |data|
      @team_players[i].player_name = data["Player Name"]
      @team_players[i].dominant_hand = data["Dominant Hand"]
      @team_players[i].bowling_style = data["Bowling Style"]
      @team_players[i].fielding_position = data["Fielding Position"]
      @team_players[i].front_foot_skill = data["Front Foot Skill"]
      @team_players[i].back_foot_skill = data["Back Foot Skill"]
      @team_players[i].bowling_skill = data["Bowling Skill"]
      i += 1
    end
  end
end