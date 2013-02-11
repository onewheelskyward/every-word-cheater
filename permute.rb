require 'sinatra'

dictionary = {}
found_words = {}

before do
	File.open("words") do |file|
		file.each do |line|
			dictionary[line.strip.downcase] = true
		end
	end

	content_type 'text/plain'
end

get "/:word" do
	permutations = params[:word].chars.to_a.permutation.map(&:join)
	permutations.each do |word|
		word5 = word[0..4]
		word6 = word[0..5]
		if dictionary[word5]
			found_words[word5] = true
		end
		if dictionary[word6]
			found_words[word6] = true
		end
		if dictionary[word]
			found_words[word] = true
		end
	end
	found_words.keys.join("\n")
end

