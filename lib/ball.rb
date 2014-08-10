class Ball
  include BallAnalytics
  def initialize(batsman, bowler)
    @batsman = batsman
    @bowler = bowler
    @batsman_skill = Integer((@batsman.front_foot_skill + @batsman.back_foot_skill)/2) + 1
    @bowler_skill = @bowler.bowling_skill
    determine_outcome
  end

  def determine_outcome
    #..
  end  
end