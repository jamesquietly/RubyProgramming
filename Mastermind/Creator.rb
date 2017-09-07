class Creator
    attr_accessor :secret, :feedback_array

    def initialize
        @secret = []
        @feedback_array = []
    end

    def generate_secret(colors)
        random = []
        colors.length.times do 
            random.push(rand() * colors.length)
        end
        @secret = [colors[random[0]], colors[random[1]], colors[random[2]], colors[random[3]]]
    end

    def feedback(guess)
        result = []
        secret_copy = @secret.map { |x| x}
        correct_positions = []

        #check for correct color and positions and award black peg
        guess.each_index do |index|
            if index < @secret.length && @secret[index] == guess[index]
                correct_positions.push(index)
                result.push("B")
            end
        end

        #delete colors that have already been checked
        correct_positions.each do |index|
            secret_copy.delete_at(index)
        end

        #check for correct color and award white peg
        guess.each_with_index do |value, index|
            if index < @secret.length
                #check if color is in the secret and if we didn't already count it in correct positions
                if secret_copy.include?(value)
                    secret_copy.delete_at(secret_copy.index(value))
                    result.push("W")
                end
            end
        end

        @feedback_array.push(result)
    end

end