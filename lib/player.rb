class Player
  attr_accessor :player_name, :team_name, :dominant_hand, :bowling_style, :fielding_position, :front_foot_skill, :back_foot_skill, :bowling_skill

  def initialize(team_name, option = :default)
    @team_name = team_name
    if option == :new_player puts "Feature in work"
  end
end
