def grabWords(inputfile, outputfile)
    file = File.open(inputfile, 'r')

    result = []
    file.readlines.each do |line|
        word = line.strip()
        if word.length > 4 && word.length < 13
            result.push(word)
        end
    end
    file.close()

    output = File.open(outputfile, 'w')
    result.each do |word|
        output.write(word + "\n")
    end
    output.close()
end

grabWords("5desk.txt", "words.txt")