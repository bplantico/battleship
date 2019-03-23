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
    if coordinates.count == ship.length && coordinates.all? do |coord|
      @cells[coord].empty?
    end
      letters = [].sort
      numbers = [].sort

      coordinates.each do |coord|
          letters << coord[0]
          numbers << coord[1].to_i
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

  def place(ship, coordinates)
    coordinates.each do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def render
    comp_rendered_board = []
    @cells.each_key do |key|
      comp_rendered_board << @cells[key].render
    end
    p comp_rendered_board

    player_rendered_board = []
    @cells.each_key do |key|
      player_rendered_board << @cells[key].render(true)
    end
    p player_rendered_board
  end

  #   letterstrt = []
  #   @cells.each_key do |key|
  #     letterstrt << @cells.each_cons(4)
  #   end

  end

end
