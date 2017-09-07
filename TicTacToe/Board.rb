=begin
0 1 2
3 4 5
6 7 8
=end

class Board
    attr_accessor :board
    
    def initialize
        @board = []
        9.times do 
            board << ""
        end
    end

    #checks if game is over
    #returns a tuple [boolean, winning symbol]
    def game_over?
        combinations = grab_combos
        result = check_combos(combinations)
        [result[0], result[1]]
    end


    #prints out board
    def print_board
        puts "\n------------\n"
        @board.each_with_index do |value, index|
            if value == ""
                string = "#{index} | "
            else
                string = "#{value.upcase} | "
            end

            if (index + 1) % 3 == 0
                string += "\n------------\n"
            end
            print string
        end
        puts " "
    end

    def place_symbol(symbol, position)
        position = position.to_i
        if position >= 0 && position < @board.length
            if @board[position] == ""
                @board[position] = symbol
            else
                puts "spot is already taken, skipping turn"
            end
        else
            puts "Not a valid position, skipping turn"
        end
    end

    private

    def grab_combos
        combinations = []
        combinations.push([@board[0], @board[1], @board[2]])
        combinations.push([@board[0], @board[3], @board[6]])
        combinations.push([@board[0], @board[4], @board[8]])

        combinations.push([@board[1], @board[4], @board[7]])
        combinations.push([@board[3], @board[4], @board[5]])
        combinations.push([@board[2], @board[4], @board[6]])

        combinations.push([@board[2], @board[5], @board[8]])
        combinations.push([@board[6], @board[7], @board[8]])

        combinations
    end

    def check_combos(array)
        result = false
        winning_combo = nil
        array.each do |combo|
            if combo[0] != "" && combo[0] == combo[1] && combo[1] == combo[2]
                result = true
                winning_combo = combo
            end
        end
        [result, winning_combo]
    end
end