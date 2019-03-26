require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Game
  attr_reader :player_board,
              :ai_board

  def initialize
    @player_board = Board.new
    @ai_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def main_menu
    puts "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      setup
    else
      puts "GOODBYE"
    end
  end

  def setup
    puts "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n" +
    "Please input three coordinates for the cruiser (i.e. 'A1 A2 A3'):"

    puts @player_board.render
    cruiser_position = gets.chomp.upcase.split(" ")

    until cruiser_position.all?{|coord| player_board.valid_coordinate?(coord)}
      puts "Not all of those coordinates are on the board. Please try again."
      cruiser_position = gets.chomp.upcase.split(" ")
    end

    until  player_board.valid_placement?(@cruiser, cruiser_position)
      puts "Those coordinates are invalid coordinates. Please try again."
      cruiser_position = gets.chomp.upcase.split(" ")
    end

    puts "Cruiser placed!"
    @player_board.place(@cruiser, cruiser_position)
    system 'clear'
    puts @player_board.render(true)

    puts "Please input two coordinates for the submarine (i.e. 'A1 A2'):"
    sub_position = gets.chomp.upcase.split(" ")

    until sub_position.all?{ |coord| player_board.valid_coordinate?(coord) }
      puts "Not all of those coordinates are on the board. Please try again."
      sub_position = gets.chomp.upcase.split(" ")
    end

    until  player_board.valid_placement?(@submarine, sub_position)
      puts "Those coordinates are invalid coordinates. Please try again."
      sub_position = gets.chomp.upcase.split(" ")
    end

    puts "Submarine placed!"
    @player_board.place(@submarine, sub_position)
    system 'clear'
    p "=============COMPUTER BOARD============="
    @ai_board.cpu_place(@cruiser)
    @ai_board.cpu_place(@submarine)
    puts @ai_board.render(true)

    p "=============PLAYER BOARD============="
    puts @player_board.render(true)


    20.times{turn}
  end






  def turn
    puts "Enter the coordinate for your shot (i.e. 'A1'):"
    guess = gets.chomp.upcase
    until @ai_board.valid_coordinate?(guess) && !@ai_board.cells[guess].fired_upon?
      puts "Invalid guess. Please try again."
      guess = gets.chomp.upcase
    end
    @ai_board.cells[guess].fire_upon

    player_result = if @ai_board.cells[guess].empty?
                      "miss."
                    elsif @ai_board.cells[guess].empty? == false && @ai_board.cells[guess].ship.sunk?
                      "hit and sunk!"
                    else
                      "hit."
                    end

    comp_guess = @player_board.cells.keys.sample
    while @player_board.cells[comp_guess].fired_upon?
      comp_guess = @player_board.cells.keys.sample
    end
    @player_board.cells[comp_guess].fire_upon
    system 'clear'

    comp_result = if @player_board.cells[comp_guess].empty? == true
              "miss."
            elsif @player_board.cells[comp_guess].empty? == false && @player_board.cells[comp_guess].sunk?
              "hit and sunk!"
            else
              "hit."
            end


    puts "Your shot on #{guess} was a #{player_result}\n"+
    "My shot on #{comp_guess} was a #{comp_result}"
    sleep(5)

    puts @ai_board.render(true)
    system 'clear'
    p "=============COMPUTER BOARD============="
    puts @ai_board.render(true)

    p "=============PLAYER BOARD============="
    puts @player_board.render(true)

  end

end
