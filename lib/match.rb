$: << File.dirname(File.absolute_path(__FILE__))

require 'securerandom'
require 'team'
require 'ball'
require 'player'
require 'batsman'
require 'bowler'

class Match
  NO_OF_BALLS_IN_OVER = 6
  def initialize(team1, team2, no_of_overs)
    @self_team = Team.new(team1, :self_team)
    @opponent_team = Team.new(team2, :opponent_team)
    @no_of_overs = no_of_overs.to_i
    @overs_completed = 0
    @no_of_innings_played = 0
    @overs = []
    intro
    toss
  end

  def intro
    puts "Hello and welcome to the beatiful contest between the two great teams #{@self_team.name_of_team.upcase} and #{@opponent_team.name_of_team.upcase}!"
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
    @batters = []
    @batting_team = team
    @strike_batsman = Batsman.new(team)
    @non_strike_batsman = Batsman.new(team)
    @no_of_innings_played += 1
    initiate_play
  end

  def bowl(team)
    @bowlers = []
    @bowling_team = team
    @one_end_bowler = Bowler.new(team)
    @other_end_bowler = Bowler.new(team)
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
    @one_end_bowler.wickets += 1
    @strike_batsman.out(@batters)
    if @wickets_taken != 10
      @strike_batsman = Batsman.new(@batting_team)
    else
      change_innings
    end
  end

  def update_score_by(runs)
    @strike_batsman.score += runs
    @strike_batsman.balls_played += 1
    @batting_team_score += runs
    @one_end_bowler.runs_conceded += runs
  end

  def change_strike
    @strike_batsman, @non_strike_batsman = @non_strike_batsman, @strike_batsman
  end

  def spell_over?
    @one_end_bowler.overs_bowled == 0.2*@no_of_overs
  end

  def new_bowler
    @one_end_bowler.spell_completed(@bowlers)
    @one_end_bowler = @other_end_bowler
    @other_end_bowler = Bowler.new(@bowling_team)
  end

  def change_bowler
    @one_end_bowler.overs_bowled += 1
    @one_end_bowler, @other_end_bowler = @other_end_bowler, @one_end_bowler
    @overs_completed += 1
  end

  def initiate_play
    @no_of_overs.times do 
      @single_over = []
      NO_OF_BALLS_IN_OVER.times do
        new_ball = Ball.new(@strike_batsman, @one_end_bowler, @overs_completed, @no_of_overs)
        @single_over << new_ball
        record(new_ball)
      end
      @overs << @single_over
      print @single_over
      change_strike
      if spell_over? 
        new_bowler
      else 
        change_bowler 
      end
    end
    change_innings
  end

  def match_innings_close
    if @wickets_taken != 10
      @strike_batsman.not_out(@batters)
      @non_strike_batsman.not_out(@batters)
    else
      @non_strike_batsman.not_out(@batters)
    end
    write_to_file("../data/India vs Australia.txt")
    #write_to_file("../data/#{@self_team.name_of_team.chomp.capitalize} vs #{@opponent_team.name_of_team.chomp.capitalize} on #{Time.now.to_s.chomp}")
  end

  def write_to_file(filee)
    File.open(filee, "w") do |file|
      file.puts "SCORECARD------------ #{@self_team.name_of_team.chomp.capitalize} vs #{@opponent_team.name_of_team.chomp.capitalize}"
      file.puts "#{@batting_team.name_of_team.chomp} innings:"
      file.puts "#{@batting_team_score} runs scored by #{@batting_team.name_of_team.chomp.capitalize}\n"
      @batters.each do |batsman|
        file.puts "#{batsman.player_name.capitalize}: #{batsman.score} runs off #{batsman.balls_played} balls, consisting of #{batsman.fours} fours and #{batsman.sixes} sixes."
      end
      file.puts "\n\n"
      @bowlers.each do |bowler|
        file.puts "#{bowler.player_name}: #{bowler.wickets} wickets off #{bowler.overs_bowled} overs, conceding #{bowler.runs_conceded} runs."
      end
    end
  end

  def change_innings
    match_innings_close
    if @no_of_innings_played == 2 
      Match.close
    else
      @overs_completed = 0
      @batting_team, @bowling_team = @bowling_team, @batting_team
      bowl(@bowling_team)
      bat(@batting_team)
    end
  end

  def Match.close
    puts "\n\nIt was a fun match for sure!"
  end
end