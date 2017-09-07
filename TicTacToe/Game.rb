require_relative 'Board'
require_relative 'Player'

class Game
    def initialize
        puts "Welcome to Tic Tac Toe!"
        puts "Rules:"
        puts "If you enter an invalid position, your turn will be skipped!"
        @board = Board.new
        puts "Enter name for Player 1:"
        p1_name = gets.chomp
        p1_symbol = valid_symbol(p1_name)
        puts "Enter name for Player 2"
        p2_name = gets.chomp
        p2_symbol = other_symbol(p1_symbol)
        puts "#{p2_name}\'s symbol is #{p2_symbol}"

        @player1 = Player.new(p1_name, p1_symbol)
        @player2 = Player.new(p2_name, p2_symbol)
    end
    #check if symbol is x or o
    def valid_symbol(name)
        valid = false
        while valid == false
            puts "#{name}, Please choose x or o:"
            symbol = gets.chomp
            if symbol.downcase == "o" || symbol.downcase == "x"
                valid = true
            end
        end
        symbol.downcase
    end

    def other_symbol(symbol)
        if symbol.downcase == "x"
            other_symbol = "o"
        else
            other_symbol = "x"
        end
        other_symbol
    end

    def determine_winner(winning_combo)
        if winning_combo[0] == @player1.symbol
            puts "Game Over! #{@player1.name} is the winner!"
        else
            puts "Game Over! #{@player2.name} is the winner!"
        end
    end

    def play
        result = @board.game_over?
        while result[0] == false
            @board.print_board
            puts "#{@player1.name}, Choose a position between 0 and 8 on the board"
            p1_choice = gets.chomp
            @board.place_symbol(@player1.symbol, p1_choice)
            result = @board.game_over?
            @board.print_board
            break if result[0]
            puts "#{@player2.name}, Choose a position between 0 and 8 on the board"
            p2_choice = gets.chomp
            @board.place_symbol(@player2.symbol, p2_choice)
            result = @board.game_over?
        end
        determine_winner(result[1])
    end
end

game = Game.new
game.play()
