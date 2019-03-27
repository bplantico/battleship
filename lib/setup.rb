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
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @ai_cruiser = Ship.new("Cruiser", 3)
    @ai_submarine = Ship.new("Submarine", 2)
  end

  def main_menu
    reset
    puts "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == "p"
      system 'clear'
      setup
    else
      puts "GOODBYE"
    end
  end

  def setup
    player_board = Board.new
    ai_board = Board.new
    puts "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n" +
    "Please input three coordinates for the cruiser (i.e. 'A1 A2 A3'):"



    puts @player_board.render(true)

    cruiser_position = gets.chomp.upcase.split(" ")

    until  cruiser_position.all?{|coord| player_board.valid_coordinate?(coord)}\
       && player_board.valid_placement?(@player_cruiser, cruiser_position)
      puts "Those coordinates are invalid coordinates. Please try again."
      cruiser_position = gets.chomp.upcase.split(" ")
    end

    puts "Cruiser placed!"
    sleep(2)
    @player_board.place(@player_cruiser, cruiser_position)
    system 'clear'
    puts @player_board.render(true)

    puts "Please input two coordinates for the submarine (i.e. 'A1 A2'):"
    sub_position = gets.chomp.upcase.split(" ")

    until sub_position.all?{ |coord| player_board.valid_coordinate?(coord) }
      puts "Not all of those coordinates are on the board. Please try again."
      sub_position = gets.chomp.upcase.split(" ")
    end

    until  player_board.valid_placement?(@player_submarine, sub_position)
      puts "Those coordinates are invalid coordinates. Please try again."
      sub_position = gets.chomp.upcase.split(" ")
    end

    puts "Submarine placed!"
    sleep(2)
    @player_board.place(@player_submarine, sub_position)
    system 'clear'

    p "=============COMPUTER BOARD============="
    @ai_board.cpu_place(@ai_cruiser)
    @ai_board.cpu_place(@ai_submarine)
    puts @ai_board.render

    p "=============PLAYER BOARD============="
    puts @player_board.render(true)

    def player_wins?
      @ai_cruiser.sunk? && @ai_submarine.sunk?
    end

    def computer_wins?
      @player_cruiser.sunk? && @player_submarine.sunk?
    end

    until player_wins? || computer_wins?
    turn
    end

    if player_wins?
      system 'clear'
      puts "You win!"
      sleep(2)
      main_menu
    else
      system 'clear'
      puts "You lose!"
      sleep(2)
      main_menu
      @ai_board.initialize
      @player_board.initialize
    end

  end

  def turn
    puts "Enter the coordinate for your shot (i.e. 'A1'):"
    guess = gets.chomp.upcase
    until @ai_board.valid_coordinate?(guess) && !@ai_board.cells[guess].fired_upon?
      puts "Invalid guess. Please try again."
      guess = gets.chomp.upcase
    end
    @ai_board.cells[guess].fire_upon

    player_result =
     if @ai_board.cells[guess].empty?
                      "miss."
      elsif @ai_board.cells[guess].empty? == false && \
            @ai_board.cells[guess].ship.sunk? == false
         "hit."
      else
        "hit and sunk! The computer's #{@ai_board.cells[guess].ship.name} is sunk."
      end

    comp_guess = @player_board.cells.keys.sample
    while @player_board.cells[comp_guess].fired_upon?
      comp_guess = @player_board.cells.keys.sample
    end
    @player_board.cells[comp_guess].fire_upon
    system 'clear'

    comp_result =
      if @player_board.cells[comp_guess].empty? == true
        "miss."
      elsif @player_board.cells[comp_guess].empty? == false && \
            @player_board.cells[comp_guess].ship.sunk? == false
            "hit"
      else
        "hit and sunk! Your #{@player_board.cells[comp_guess].ship.name} is sunk."
      end

    puts "Your shot on #{guess} was a #{player_result}\n"+
    "My shot on #{comp_guess} was a #{comp_result}"
    sleep(4)

    puts @ai_board.render
    system 'clear'
    p "=============COMPUTER BOARD============="
    puts @ai_board.render

    p "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def reset
    @player_board = Board.new
    @ai_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @ai_cruiser = Ship.new("Cruiser", 3)
    @ai_submarine = Ship.new("Submarine", 2)
  end

end
