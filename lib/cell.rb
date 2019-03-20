class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
     @ship## false when inputed length == length
    ## true when fire_upon
  end

  def fire_upon
    @ship.hit
  end

end
