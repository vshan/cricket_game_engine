class Batsman < Player
  attr_accessor :balls_played, :score, :fours, :sixes, :dots, :twos, :ones

  def initialize(team)
  	@balls_played = 0
  	@score = 0
  	@fours = 0
  	@sixes = 0
  	@dots = 0
  	@twos = 0
  	@ones = 0
  end

  def out
  	
  end

end