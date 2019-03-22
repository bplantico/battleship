require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_if_cells_creates_16_values
    board = Board.new

    assert_equal 16, board.cells.count
    assert_instance_of Cell, board.cells["D3"]
  end

  def test_if_coordinate_valid
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement_method_when_wrong_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert board.valid_placement?(cruiser, ["A2", "A3", "A4"])
    assert board.valid_placement?(submarine, ["A1", "A2"])
  end

  def test_valid_placement_for_consecutive_coordinates

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])

  end

end

# pry(main)> board.valid_placement?(cruiser, ["A1", "A2"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["A2", "A3", "A4"])
# # => false
#
# pry(main)> board.valid_placement?(cruiser, ["A1", "A2", "A4"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["A1", "C1"])
# # => false
#
# pry(main)> board.valid_placement?(cruiser, ["A3", "A2", "A1"])
# # => false
#
# pry(main)> board.valid_placement?(submarine, ["C1", "B1"])
# # => false
