class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon,
              :empty

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)

    @ship = ship
  end

  def render(reveal = false)
     if @fired_upon == false && empty? == true
      "."
    elsif @fired_upon == true && empty? == true
      "M"
    elsif @ship.sunk?
      "X"
    elsif @fired_upon == false && empty? == false && reveal == false
      "."
    elsif @fired_upon == false && empty? == false
      "S"
    else @fired_upon == true && empty? == false
      "H"
    end
  end

  def fired_upon?
     @fired_upon
  end

  def fire_upon
    if empty?
      @fired_upon = true
    else
      @ship.hit
      @fired_upon = true
    end
  end

end
