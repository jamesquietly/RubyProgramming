require 'yaml'

class Hangman
    attr_accessor :word, :max_turn, :current_turn, :display_word, :current_guess

    def initialize
        @word = choose_word
        @max_turn = 12
        @current_turn = 1
        @display_word = ""
        @word.length.times do 
            @display_word += "_"
        end
        @current_guess = ""
    end

    #choose a random word from words.txt
    def choose_word
        input = File.open("words.txt", 'r')
        words = []
        input.readlines.each do |line|
            words.push(line.strip().downcase)
        end
        input.close()
        words[rand(words.length)]
    end

    #parse the first letter from user input
    def parse_letter(input)
        input = input.strip()
        letter = ""
        if input != ""
            letter = input[0].downcase
        end
        letter
    end

    #update the underscores to show correct letters
    def update_display_word
        length = @word.length
        length.times do |i|
            if @word[i] == @current_guess
                @display_word[i] = @word[i]
            end
        end
    end

    def end_message
        if @display_word.include?("_")
            puts "Gamer Over! You lost."
        else
            puts "Game Over! You won!"
        end
        puts "The word was \"#{@word}\""
    end

    def welcome
        puts "Welcome to Hangman!"
        if File.exists?("hangman.yaml")
            load_game()
        else
            puts "Try to guess the word in 12 turns."
            puts "Enter \"+\" sign at any turn to save progress."
        end
        puts " "
    end

    #load game state from yaml file
    def load_game
        puts "Would you like to load a saved game?"
        puts "Enter \"y\" or \"n\":"
        input = gets.chomp
        if input != "" && input[0].downcase == "y"
            game = YAML.load(File.read("hangman.yaml"))
            @word = game[:word]
            @max_turn = game[:max_turn]
            @current_turn = game[:current_turn]
            @display_word = game[:display_word]
            @current_guess = game[:current_turn]
        end
        puts "Game is loaded!"
    end

    #save game to yaml file
    def save_game
        game = {
            :word => @word,
            :max_turn => @max_turn,
            :current_turn => @current_turn,
            :display_word => @display_word,
            :current_guess => @current_guess
        }
        File.open("hangman.yaml", 'w') { |f| f.write(game.to_yaml)}
        print "Game is saved!\n"
    end

    #main loop for game
    def play
        welcome()
        while @current_turn <= @max_turn && @display_word.include?("_")
            puts "Turn #{@current_turn} out of #{@max_turn}"
            puts "Word: #{@display_word}"
            puts "Enter a letter for a guess (will only count first letter):"
            @current_guess = parse_letter(gets.chomp)
            if @current_guess == "+"
                save_game()
            else
                @current_turn +=1
            end
            update_display_word()
        end
        end_message()
    end
end

hangman = Hangman.new
hangman.play()