require_relative 'Creator'
require_relative 'Guesser'

class Mastermind
    attr_accessor :colors, :max_turn, :creator, :guesser, :current_guess, :current_turn

    def initialize
        @max_turn = 12
        @colors = ["red", "green", "blue", "yellow", "orange", "violet"]
        @creator = Creator.new
        @creator.generate_secret(colors)
        @guesser = Guesser.new
        @current_guess = ""
        @current_turn = 1
    end

    def welcome
        puts "Welcome to Mastermind!"
        puts "Guess the secret combination of colors."
        puts " "
    end
    
    # returns a boolean indicating if game is over or not
    # and a winning message
    # returns [boolean, winning_message]
    def game_over?
        result = false
        winning_message = "Creator has won!"
        if @current_guess == "" || @current_guess.length < 4
            return [result, winning_message]
        elsif @current_guess[0] == @creator.secret[0] && @current_guess[1] == @creator.secret[1] && @current_guess[2] == @creator.secret[2] && @current_guess[3] == @creator.secret[3]
            result = true
            winning_message = "Guesser has won!"
        elsif @current_turn > @max_turn
            result = true
        end
        [result, winning_message]
    end

    def parse_input(input)
        result = []
        if input.include?(",")
            result = input.split(",")
            result.each do |word|
                word.strip!
            end
        else
            result << input.strip
        end
        result
    end

    def display_board
        puts " "
        puts "            guess                       ---       feedback"
        print
        @guesser.guesses.each_with_index do |guess, index|
            print "#{index}: "
            guess.each do |val|
                print "#{val} | "
            end
            print " --- "
            @creator.feedback_array[index].each do |fb|
                print " #{fb} -"
            end

            print "\n"
        end
        
        puts " "
    end


    def play
        welcome()
        game_result = self.game_over?
        while game_result[0] == false && @current_turn <= @max_turn
            if current_turn > 1
                display_board()
            end
            puts "Turn \##{current_turn}"
            puts "Possible colors:"
            @colors.each_with_index do |color, index|
                if index == colors.length - 1
                    print color + "\n"
                else
                    print color + ", "
                end
            end
            puts "Enter a 4 color combination (example: red, blue, green, yellow):\n"
            player_colors = gets.chomp
            @current_guess = parse_input(player_colors)
            @guesser.add_guess(@current_guess)
            @creator.feedback(@current_guess)
            @current_turn += 1
            game_result = game_over?
        end
        puts game_result[1]
    end
end

mastermind = Mastermind.new
mastermind.play()