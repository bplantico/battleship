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
          false
      end
    else
      false
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def render(reveal = false)
    if reveal == true
      player_rendered_board = ["  1"," 2"," 3"," 4", " \n"]
      player_rendered_board << "A " + "#{@cells["A1"].render(true)}" + " #{@cells["A2"].render(true)}" + " #{@cells["A3"].render(true)}" + " #{@cells["A4"].render(true)}" + " \n"
      player_rendered_board << "B " + "#{@cells["B1"].render(true)}" + " #{@cells["B2"].render(true)}" + " #{@cells["B3"].render(true)}" + " #{@cells["B4"].render(true)}" + " \n"
      player_rendered_board << "C " + "#{@cells["C1"].render(true)}" + " #{@cells["C2"].render(true)}" + " #{@cells["C3"].render(true)}" + " #{@cells["C4"].render(true)}" + " \n"
      player_rendered_board << "D " + "#{@cells["D1"].render(true)}" + " #{@cells["D2"].render(true)}" + " #{@cells["D3"].render(true)}" + " #{@cells["D4"].render(true)}" + " \n"
      player_rendered_board.join
    else
      player_rendered_board = ["  1"," 2"," 3"," 4", " \n"]
      player_rendered_board << "A " + "#{@cells["A1"].render}" + " #{@cells["A2"].render}" + " #{@cells["A3"].render}" + " #{@cells["A4"].render}" + " \n"
      player_rendered_board << "B " + "#{@cells["B1"].render}" + " #{@cells["B2"].render}" + " #{@cells["B3"].render}" + " #{@cells["B4"].render}" + " \n"
      player_rendered_board << "C " + "#{@cells["C1"].render}" + " #{@cells["C2"].render}" + " #{@cells["C3"].render}" + " #{@cells["C4"].render}" + " \n"
      player_rendered_board << "D " + "#{@cells["D1"].render}" + " #{@cells["D2"].render}" + " #{@cells["D3"].render}" + " #{@cells["D4"].render}" + " \n"
      player_rendered_board.join
    end
  end



end
