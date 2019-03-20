class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon,
              :empty

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
    @empty = true
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @empty = false
    @ship = ship
  end

  def render(reveal = false)

# If argument is true, show the S block
# If argument is false, show dot block
    if @fired_upon == false && @empty == false && reveal == false
      "."
    elsif @fired_upon == false && @empty == false
      "S"
    elsif @fired_upon == false && @empty == true
      "."
    elsif @fired_upon == true && @empty == true
      "M"
    else  @fired_upon == true && @empty == false
      "H"
    end
  end

  def fired_upon?
     @fired_upon
  end

  def fire_upon
    if @empty
      @fired_upon = true
    else
      @ship.hit
      @fired_upon = true
    end
  end

end
