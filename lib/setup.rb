require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Game
  attr_reader :player_board,
              :ai_board

  def initialize
    @player_board = Board.new
    @ai_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def main_menu
    puts "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit."
    input = gets.chomp
    # if input == "p" || "P"
    #
    # elsif input == "q" || "Q"
    # end
  end

  def setup
    puts "I have laid out my ships on the grid.
You now need to lay out your two ships.
The Cruiser is three units long and the Submarine is two units long.
Please input three coordinates for the cruiser (i.e. 'A1 A2 A3'):"
    puts @player_board.render
    cruiser_position = gets.chomp.upcase.split(" ")
    until player_board.valid_placement?(@cruiser, cruiser_position)
        puts "Those coordinates are no fucking good. Try again."
        coord = gets.chomp

      # p "Cruiser placed!"
      # @player_board.place_ship(cruiser, cruiser_position)

    end




  end


  def turn
  end

end
