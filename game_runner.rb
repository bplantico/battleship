
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup.rb'
require 'pry'


    player_board = Board.new
    ai_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    game = Game.new

    game.setup
