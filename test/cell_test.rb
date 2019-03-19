require 'minitest/autorun'
require 'minitest/emoji'
require 'pry'
require './lib/ship'
require './lib/cell'

class CellTest < MiniTest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_ship_method_returns_nil_by_default
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_place_ship_adds_ship_to_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
  end

  def test_empty_by_default_and_not_after_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    assert cell.empty?
    cell.place_ship(cruiser)
    refute cell.empty?
  end

end
