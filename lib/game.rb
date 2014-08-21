$: << File.dirname(File.absolute_path(__FILE__))

require 'search'
require 'match'
require 'team'

class Game
  include Search
  def initialize(name)
    @@game_name = name
    introduce
    new_game
  end
  
  def introduce
    puts "Hello and welcome to #{@@game_name}."
  end

  def new_game
    puts "Which two teams would you like to play with and how many overs?"
    display_teams
    team_1, team_2, no_of_overs = gets.split
    Match.new(team_1, team_2, no_of_overs)
  end

  def display_teams
    take_options_from_file_and_display("../data/teams.txt")
  end
end

Game.new("CRICKET")