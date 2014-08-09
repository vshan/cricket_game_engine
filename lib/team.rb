class Team

  attr_accessor :name_of_team
  attr_reader :team_id
  
  def initialize(team)
    @team_id = team
    @@no_of_players_in_team = 11
    @@teams = take_options_from_file_return_array("..\data\teams.txt")
    set_name_of_team(@team_id)
    load(@team_id)
  end

  def set_name_of_team(id)
    @name_of_team = @@teams[id-1]
  end

  def load(team)
    @team_players = []
    for i in 0...@@no_of_players_in_team
      @team_players[i] = Player.new(@name_of_team)
    end
  end

end