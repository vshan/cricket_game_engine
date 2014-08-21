class Bowler < Player
  attr_accessor :overs_bowled, :wickets

  def initialize(team)
  	@overs_bowled = 0
    @wickets = 0

  	select_bowler(team) 
  end

  def spell_complete(bowlers)
    bowlers.push(self)
  end

  def select_bowler(team)
  	team.team_players.each do |player|
  		if player.bowl_status == :not_played
        new_bowler(player)
        player.bowl_status = :played
      elsif player.bowl_status == :bowling
        new_bowler()
        break
      end 
  	end
  end

  def new_bowler(player)
    
  end
end
