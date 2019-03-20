require 'minitest/autorun'
require 'minitest/pride'
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

  def test_if_cell_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.fired_upon?
  end

  def test_if_cell_when_fired_loses_health
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end
end

#
# pry(main)> cell.fired_upon?
# # => false
#
# pry(main)> cell.fire_upon
#
# pry(main)> cell.ship.health
# # => 2
#
# pry(main)> cell.fired_upon?
# # => true
