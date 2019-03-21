require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_if_cells_creates_16_values
    board = Board.new
    board.create_cells
    assert_equal 16, board.cells.count
    assert_instance_of Cell, board.cells["D3"]
  end

  def test_if_coordinate_valid
    board = Board.new
    board.create_cells
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end
end
