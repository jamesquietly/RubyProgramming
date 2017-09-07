#count number of times word appears in string
def count(string, word)
    count = 0
    #break into array of characters
    array = string.each_char
    #enumerate string based on word length
    array = array.each_cons(word.length).to_a
    #join enumerations into substrings
    enumeration = array.map(&:join)
    enumeration.each do |enum|
        if enum == word
            count += 1
        end
    end
    count
end

def substrings(string, dictionary)
    result = {}
    dictionary.each do |word|
        if string.include?(word)
            result[word] = count(string, word)
        end
    end
    result
end
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)