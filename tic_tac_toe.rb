# This module is how players interact with the game and input their symbol. It's seperated from the rest of the game for
# practice and organization, but would work just as well if it was a part of the TttGame class!
module PlayerInteraction
  def place_marker(team_symbol)
    puts "Which square would you like to place a #{team_symbol} at? (1 - 9)"
    placed_square = gets.chomp
    if placed_square.to_i.positive? && placed_square.to_i <= 9 && !@squares[placed_square].is_a?(Symbol)
      @squares[placed_square] = team_symbol
      @game_round += 1
    else
    puts 'Invalid option, please type a number from 1 - 9 that has not been chosen!'
    end
    game_board()
    game_over?()
  end
end

# This class is where the game is stored. On initalization, it resets the game squares from 1-9 and the round to 1.
# The game_over? module checks if the game has ended by a winning combination of '3-in-a-row' has been met.
# The game_board module prints a visual of the board. By default, the values are 1-9 but are overridden with X and O by the player
# The start_game module identifies which player's turn is active or if the game has ended due to a winning combo or a tie
class TttGame
  include PlayerInteraction
  def initialize()
    @squares = { '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9 }
    @game_round = 1
    @game_over = false
  end

  def game_over?
    # Win combinations are = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]
    if @squares['1'] == @squares['2'] && @squares['2'] == @squares['3'] ||
       @squares['4'] == @squares['5'] && @squares['5'] == @squares['6'] ||
       @squares['7'] == @squares['8'] && @squares['8'] == @squares['9'] ||
       @squares['1'] == @squares['5'] && @squares['5'] == @squares['9'] ||
       @squares['3'] == @squares['5'] && @squares['5'] == @squares['7'] ||
       @squares['1'] == @squares['4'] && @squares['4'] == @squares['7'] ||
       @squares['2'] == @squares['5'] && @squares['5'] == @squares['8'] ||
       @squares['3'] == @squares['6'] && @squares['6'] == @squares['9']
    @game_over = true
    end
  end

  def game_board()
    puts " #{@squares['1']} | #{@squares['2']} | #{@squares['3']} "
    puts "-----------"
    puts " #{@squares['4']} | #{@squares['5']} | #{@squares['6']} "
    puts "-----------"
    puts " #{@squares['7']} | #{@squares['8']} | #{@squares['9']} "
    puts
  end

  def start_game
    game_board()
    while @game_over == false && @game_round < 10
      if @game_round.even?
        puts "It is O's turn!"
        place_marker(:o)
      else
        puts "It is X's turn!"
        place_marker(:X)
      end

      if @game_round == 10 && @game_over == false
        puts 'Tied game!'
      elsif @game_over == true && @game_round.even?
        puts 'Player X wins!!!!!!'
      elsif @game_over == true
        puts 'Player O wins!!!!!!'
      end
    end
  end
end
tictactoe = TttGame.new
tictactoe.start_game
