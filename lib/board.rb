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
    # Length check and overlap check
    if coordinates.count == ship.length && coordinates.all? do |coord|
      @cells[coord].empty?
    end
    
      letters = [].sort
      numbers = [].sort
    
      coordinates.each do |coord|
          letters << coord[0]
          numbers << coord[1].to_i
      end
      # Horizontal and vertical consecutive checks
      if letters.uniq.length == 1
          numbers.each_cons(2).all?{|x, y| y == x + 1}
        elsif numbers.uniq.length == 1
          letters.each_cons(2).all?{|x, y| y.ord == x.ord + 1}
        else
          return  false
      end
    else
      return false
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def render(reveal = false)
    letters = []
    numbers = []
    @cells.keys.each do |cells|
      letters << cells[0]
      numbers << cells[1]
    end
    board =  " #{numbers.uniq.join(" ")} \n"
    letters.uniq.each do |let|
      board += "#{let} "
      numbers.uniq.each do |num|
        coord = "#{let}#{num}"
         board += "#{@cells[coord].render(reveal)} "
      end
      board += "\n"
    end
    board
  end
end
   