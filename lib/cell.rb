class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon,
              :render,
              :empty

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
    @render = "."
    @empty = true
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @empty = false
    @ship = ship
  end

  def fired_upon?
     @fired_upon
  end

  def fire_upon

    if @empty
      @render = "M"
    else
      @ship.hit
      @render = "H"
      @fired_upon = true
    end

  end

end
