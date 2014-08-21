$: << File.dirname(File.absolute_path(__FILE__))

require 'securerandom'
require 'batsman'
require 'bowler'

class Ball
  def initialize(batsman, bowler, overs, total_overs)
    @batsman = batsman
    @bowler = bowler
    @batsman_skill = Integer((@batsman.front_foot_skill + @batsman.back_foot_skill)/2) + 1
    @bowler_skill = @bowler.bowling_skill
    @outcomes = []
    @overs = overs
    @total_overs = total_overs
    determine_outcome
  end

  @@determine_probability = lambda { |probability, outcome|
    if SecureRandom.random_number(100) < probability*100 
      @outcomes.push(outcome)
    end
  }

  def determine_outcome
    if @overs < 0.2*@total_overs 
      initial_phase
    elsif @overs >= 0.2*@total_overs && @overs < 0.4*@total_overs
      mid_initial_phase
    elsif @overs >= 0.4*@total_overs && @overs < 0.6*@total_overs
      mid_phase
    elsif @overs >= 0.6*@total_overs && @overs < 0.8*@total_overs
      post_mid_phase
    else
      final_phase
    end
    if @outcomes.size == 0 @outcomes.push(0)
    @outcomes[SecureRandom.random_number(outcomes.size)]
  end

  def bat_ball_prob(@batsman_skill, @bowler_skill)
    @batsman_skill > @bowler_skill ? @batsman_skill/@bowler_skill.to_f : @bowler_skill/@batsman_skill.to_f
  end

  def initial_phase
    set_probability(0.5, 0.5, 0.27, 0.2, 0.1, 0.31) 
  end

  def mid_initial_phase
    set_probability(0.3, 0.6, 0.4, 0.2, 0.1, 0.2)
  end

  def mid_phase
    set_probability(0.3, 0.5, 0.4, 0.4, 0.2, 0.1)
  end

  def post_mid_phase
    set_probability(0.2, 0.4, 0.6, 0.5, 0.2, 0.4)
  end

  def final_phase
    set_probability(0.1, 0.3, 0.5, 0.6, 0.5, 0.5)
  end

  def set_probability(dot, one, two, four, six, wicket)
    @@determine_probability.call dot*bat_ball_prob(@batsman_skill, @bowler_skill), 0
    @@determine_probability.call one*bat_ball_prob(@batsman_skill, @bowler_skill), 1
    @@determine_probability.call two*bat_ball_prob(@batsman_skill, @bowler_skill), 2
    @@determine_probability.call four*bat_ball_prob(@batsman_skill, @bowler_skill), 4
    @@determine_probability.call six*bat_ball_prob(@batsman_skill, @bowler_skill), 6
    @@determine_probability.call wicket*bat_ball_prob(@batsman_skill, @bowler_skill), "W"
  end
end