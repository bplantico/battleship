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

  def valid_placement?(ship, coordinates)
    if #{valid_length} == false
      false
    end


    # Are the cells consecutive?
    # Do the ships overlap?
    # If all pass above, then the placement is valid
  end

# Is the ship length the same length as the number of coordinates provided?
# If true, then the length is valid.
  def valid_length(ship, coordinates)
    coordinates.count == ship.length
  end

  # def valid_consecutive
  #   # H - Is the placement horizontal and consecutive?
  #   # V - Is the placement vertical and consecutive?
  #   # If H or V is true, then valid consecutive is true
  # end

end
