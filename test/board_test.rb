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

  def test_if_valid_placement_works_vertical
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_if_valid_placement_works_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute  board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_if_valid_placement_returns_true
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_place_ship_method
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_instance_of Ship, cell_1.ship
    assert_instance_of Ship, cell_2.ship
    assert_instance_of Ship, cell_3.ship

    assert cell_3.ship == cell_2.ship
  end

  def test_if_valid_placement_returns_false_on_overlaps
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    submarine = Ship.new("Submarine", 2)
    refute board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_render_the_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expected_opp = "  1 2 3 4 \n" +
                   "A . . . . \n" +
                   "B . . . . \n" +
                   "C . . . . \n" +
                   "D . . . . \n"

    assert_equal expected_opp, board.render

    expected_player = "  1 2 3 4 \n" +
                      "A S S S . \n" +
                      "B . . . . \n" +
                      "C . . . . \n" +
                      "D . . . . \n"

    assert_equal expected_player, board.render(true)

  end

  def test_render_the_board__again
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["B2", "C2"])

    board.cells["B2"].fire_upon
    board.cells["C3"].fire_upon

    expected_opp = "  1 2 3 4 \n" +
                   "A . . . . \n" +
                   "B . H . . \n" +
                   "C . . M . \n" +
                   "D . . . . \n"

    assert_equal expected_opp, board.render

    expected_player = "  1 2 3 4 \n" +
                      "A S S S . \n" +
                      "B . H . . \n" +
                      "C . S M . \n" +
                      "D . . . . \n"

    assert_equal expected_player, board.render(true)

    board.cells["C2"].fire_upon
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon

    expected_player = "  1 2 3 4 \n" +
                      "A X X X . \n" +
                      "B . X . . \n" +
                      "C . X M . \n" +
                      "D . . . . \n"

    assert_equal expected_player, board.render(true)
  end

  def test_computer_places_ships
    cpu_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    cpu_board.cpu_place(cruiser)
    cpu_board.cpu_place(submarine)
    cpu_board.render(true)

    assert cpu_board.cells.values.any? { |cell| cell.ship == cruiser }
    assert cpu_board.cells.values.any? { |cell| cell.ship == submarine }
  end

end
