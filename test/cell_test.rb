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

  def test_cell_is_empty_by_default
    cell = Cell.new("B4")
    
    assert cell.empty?
  end

end
# pry(main)> cell.empty?
# # => true
#
# pry(main)> cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0891238...>
#
# pry(main)> cell.place_ship(cruiser)
#
# pry(main)> cell.ship
# # => #<Ship:0x00007f84f0891238...>
#
# pry(main)> cell.empty?
# # => false
