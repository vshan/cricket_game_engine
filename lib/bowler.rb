$: << File.dirname(File.absolute_path(__FILE__))


require 'player'
require 'team'

class Bowler < Player
  attr_accessor :overs_bowled, :wickets, :runs_conceded

  def initialize(team)
  	@overs_bowled = 0
    @wickets = 0
    @runs_conceded = 0

  	select_bowler(team)
  end

  def spell_completed(bowlers)
    bowlers.push(self)
  end

  def select_bowler(team)
  	team.team_players.each do |player|
  		if player.bowl_status == :not_played
        new_bowler(player)
        player.bowl_status = :played
        break
      end
  	end
  end

  def new_bowler(player)
    self.player_name = player.player_name
    self.team_name = player.team_name
    self.bowling_skill = player.bowling_skill
  end
end
