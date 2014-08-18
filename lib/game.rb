require_relative 'search.rb'
class Game
  include Search
  def initialize(name)
    @@game_name = name
    introduce
    give_options
    take_options
  end
  
  def introduce
    puts "Hello and welcome to #{@@game_name}."
  end

  def give_options
    puts "\nWhat would you like to do today?"
    take_options_from_file_and_display("../data/initial_options.txt")    
  end

  def take_options
    option = gets.to_i
    #remember to raise exception whenever input not an integer
    case option
    when 1
      new_game
    when 2
      Player.new(:new_player) #option to make a new player
    when 3
      Tournament.new
    else
      puts "Please enter a valid option."
    end
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