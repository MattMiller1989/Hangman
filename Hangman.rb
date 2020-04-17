file=File.open("5desk.txt")

words=file.read.split

valid_words=[]
words.each do |word|
    if word.length<=12 && word.length>=5
        valid_words.push(word)
    end
end

puts valid_words.sample


