class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon,
              :render

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
    @render = "."
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
     @fired_upon
  end

  def fire_upon
    @ship.hit
    @fired_upon = true
  end

end
