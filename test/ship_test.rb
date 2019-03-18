require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/ship'

class ShipTest < MiniTest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_cruiser_exists
    assert_instance_of Ship, @cruiser
  end

  def test_ship_name_return
    assert_equal "Cruiser", @cruiser.name
  end

  def test_ship_length_return
    assert_equal 3, @cruiser.length
  end

  def test_cruiser_health
    assert_equal 3, @cruiser.health
  end

  def test_ship_sunk

  refute @cruiser.sunk?
  end

  def test_hit_method_reduces_health
    @cruiser.hit

    assert_equal 2, @cruiser.health

  end
end

# pry(main)> cruiser.hit
#
# pry(main)> cruiser.health
# #=> 2
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.health
# #=> 1
#
# pry(main)> cruiser.sunk?
# #=> false
#
# pry(main)> cruiser.hit
#
# pry(main)> cruiser.sunk?
# #=> true
