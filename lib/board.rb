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
    if   coordinates.count == ship.length
          letters = []
          numbers = [].sort

          coordinates.each do |coord|
            letters << coord[0]
            numbers << coord[1].to_i
          end

          unique_letters = letters.uniq

          unique_letters.length == 1
          numbers.each_cons(2).all?{|x, y| y == x + 1}
        else
          false
        end
    # Do the ships overlap?
    # If all pass above, then the placement is valid
  end

  # def h_consec?(coordinates) # Are the cells consecutive?

    # letters = []
    # numbers = []
    #
    # coordinates.each do |coord|
    #   letters = coord.first.sort
    #   numbers = coord.last.sort
    # end
    #
    # unique_letters = letters.uniq
    #
    # unique_letters.length == 1
    # numbers.each_cons(2).all?{|x, y| y == x + 1}
    # first_num = numbers.first.to_i
    # later_nums = numbers.drop(1)
    # later_nums.each do |num|
    #   if num.to_i != first_num + 1
    #     return false
    #   else
    #     first_num = num.to_i
    #   end
    # end
    # return true
  # end


  # def valid_consecutive(ship, coordinates)
  #   # H - Is the placement horizontal and consecutive?
  #
  #   # V - Is the placement vertical and consecutive?
  #   # If H or V is true, then valid consecutive is true
  # end

end
