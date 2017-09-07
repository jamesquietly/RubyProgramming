#a-z is 97-122
#shift letter by specific amount
def shift(letter, amount)
    new_letter = letter.downcase.ord + amount
    new_letter %= 122
    if new_letter < 96
        new_letter += 96
    end

    if letter == letter.upcase
        new_letter.chr.upcase
    else
    	  new_letter.chr
    end
end

#go through string and shift letters
def caesar_cipher(string, shift_amount)
	  array = string.split("")
    cipher = array.map do |letter|
    	   if "~`-+=_!@\#{$%^&*()}[]\\|\'\"".include?(letter)
    	       letter
         elsif letter != " "
             shift(letter, shift_amount)
         else
             " "
         end
    end
    cipher.join()
end

puts caesar_cipher("What a string!", 5)