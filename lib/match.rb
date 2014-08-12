require 'securerandom'
class Match
  @@no_of_balls_in_over = 6
  def initialize(team1, team2, no_of_overs)
    @self_team = Team.new(team1, :self_team)
    @opponent_team = Team.new(team2, :opponent_team)
    @no_of_overs = no_of_overs
    @overs_completed = 0
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
  end

  def take_toss_decision(team)
    if team == :self_team
      decision = gets.strip
      case decision
      when "bat"
        bowl(@opponent_team)
        bat(@self_team)
      else
        bowl(@self_team)
        bat(@opponent_team)
      end
    else
      if SecureRandom.random_number(1000) >= 500
        bowl(@self_team)
        bat(@opponent_team)
      else
        bowl(@opponent_team)
        bat(@self_team)
      end
    end
  end

  def bat(team)
    @batting_team = team
    @strike_batsman = Batsman.new(team)
    @non_strike_batsman = Batsman.new(team)
    initiate_play
  end

  def bowl(team)
    @bowling_team = team
    @bowler = Bowler.new(team)
  end

  def record(ball)
    case ball
    when 1
      run_a_single
    when 2
      run_a_double
    when 4
      hit_a_four
    when 6
      hit_a_six
    when "W"
      wicket
    else 
      dot_ball
    end
  end

  def run_a_single
    update_score_by(1)
    @strike_batsman.ones += 1
    change_strike
  end

  def run_a_double
    update_score_by(2)
    @strike_batsman.twos += 1
  end

  def hit_a_four
    update_score_by(4)
    @strike_batsman.fours += 1
  end

  def hit_a_six
    update_score_by(6)
    @strike_batsman.sixes += 1
  end

  def dot_ball
    @strike_batsman.balls_played += 1
    @strike_batsman.dots += 1
  end

  def wicket
    @strike_batsman.balls_played += 1
    @bowler.wickets += 1
    @strike_batsman.out
    if @bowling_team.wickets != 10
      @strike_batsman = Batsman.new(@batting_team)
    else
      change_innings
    end
  end

  def update_score_by(runs)
    @strike_batsman.score += runs
    @strike_batsman.balls_played += 1
    @batting_team.team_score += runs
    @bowler.runs_conceded += runs
  end

  def change_strike
    @strike_batsman, @non_strike_batsman = @non_strike_batsman, @strike_batsman
  end

  def change_bowler
    @bowler.overs_bowled += 1
    @overs_completed += 1
    @bowler = Bowler.new(@bowling_team)
  end

  def initiate_play
    for i in 0...@no_of_overs
      for j in 0...@@no_of_balls_in_over
        @overs[i][j] = Ball.new(@strike_batsman, @bowler, @overs_completed, @no_of_overs)
        record(@overs[i][j])
      end
      change_strike
      change_bowler
    end
    change_innings
  end

  def Match.close
    write_to_file("../data/#{@self_team.name_of_team.capitalize} vs #{@opponent_team.name_of_team.capitalize} on #{Time.now}.txt")
  end

  def write_to_file
    File.open("../data/#{@self_team.name_of_team.capitalize} vs #{@opponent_team.name_of_team.capitalize} on #{Time.now}.txt", "w") do |file|

    end
  end

  def change_innings
    @batting_team.innings_over
    @overs_completed = 0
    if have_both_teams_batted?
      Match.close
    else
      @batting_team, @bowling_team = @bowling_team, @batting_team
      bowl(@bowling_team)
      bat(@batting_team)
    end
  end
end


