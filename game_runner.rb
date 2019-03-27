require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/setup.rb'
require 'pry'

player_board = Board.new
ai_board = Board.new
# player_cruiser = Ship.new("Cruiser", 3)
# player_submarine = Ship.new("Submarine", 2)
# ai_cruiser = Ship.new("Cruiser", 3)
# ai_submarine = Ship.new("Submarine", 2)
game = Game.new

game.setup
