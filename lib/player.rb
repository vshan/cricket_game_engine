class Player
  attr_accessor :player_name, :team_name, :dominant_hand, :bowling_style, :fielding_position, :front_foot_skill, :back_foot_skill, :bowling_skill, :bat_status, :bowl_status

  def initialize(team_name = "India")
    @team_name = team_name
    @bat_status = :not_played
    @bowl_status = :not_played
  end
end
