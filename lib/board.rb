class Board
  attr_reader :cells
  def initialize
    @cells = create_cells
  end

  def create_cells
    cells = {}
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        cells[coordinate] = Cell.new(coordinate)
      end
    end
    cells
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  # Is the ship length the same length as the number of coordinates provided?
  # If true, then the length is valid.

  def valid_placement?(ship, coordinates) #Returns True or False
    if coordinates.count == ship.length
      letters = [].sort
      numbers = [].sort

      coordinates.each do |coord|
        # if valid_coordinate?(coord)
          letters << coord[0]
          numbers << coord[1].to_i
        # end
      end

      if letters.uniq.length == 1
          numbers.each_cons(2).all?{|x, y| y == x + 1}
        elsif numbers.uniq.length == 1
          letters.each_cons(2).all?{|x, y| y.ord == x.ord + 1}
        else
          false
      end
    else
      false
    end
  end

# Given the name of a ship and a coordinates array of where to put it, place the ship into the cells.
  def place(ship, coordinates)
    coordinates.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end


end
