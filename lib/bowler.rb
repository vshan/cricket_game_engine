class Bowler < Player
  attr_accessor :overs_bowled, :wickets

  def initialize(team)
  	@overs_bowled ||= 0

  	select_bowler(team) 
  end

  def select_bowler(team)
  	team.team_players.each do |bowler|
  		
  	end
  end
end
