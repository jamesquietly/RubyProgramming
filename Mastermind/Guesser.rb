class Guesser
    attr_accessor :guesses
    
    def initialize
        @guesses = []
    end

    def add_guess(guess)
        @guesses.push(guess)
    end

end