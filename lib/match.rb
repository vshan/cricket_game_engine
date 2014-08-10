require 'securerandom'

class Match
  @@no_of_balls_in_over = 6
  def initialize(team1, team2, no_of_overs)
    @self_team = Team.new(team1, :self_team)
    @opponent_team = Team.new(team2, :opponent_team)
    @no_of_overs = no_of_overs
    intro
    toss
  end

  def intro
    puts "Hello and welcome to the beatiful contest between the two great teams #{@self_team.upcase} and #{@opponent_team.upcase}!"
  end

  def toss
    puts "Let's get to the toss!"
    SecureRandom.random_number(1000) >= 500? toss_win(:self_team) : toss_win(:opponent_team)
  end

  def toss_win(team)
    if team == :self_team
      puts "Congrats! You won the toss. Would you like to bat or bowl first?"
      take_toss_decision(:self_team)
    else 
      puts "You've lost the toss."
      take_toss_decision(:opponent_team)
  end

  def take_toss_decision(team)
    if team == :self_team
      decision = gets.strip
      case decision
      when "bat"
        bat(@self_team)
      else
        bowl(@self_team)
      end
    else
      SecureRandom.random_number(1000) >= 500? bat(@opponent_team) : bowl(@opponent_team)
  end

  def bat(team)
    @strike_batsman = Batsman.new(team)
    @non_strike_batsman = Batsman.new(team)
  end

  def bowl(team)
    @bowler = Bowler.new(team)
  end
end


# Overs[50] = [[1, 2, 3, "W", 4, 0, 6], [], ...]
#

for i in 0...@no_of_overs
  for j in 0...@@no_of_balls_in_over
    @over[i][j] = Ball.new(@strike_batsman, @bowler)
    record(@over[i][j])
  end
end