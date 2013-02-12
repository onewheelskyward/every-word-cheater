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

# todo: store results in a database to eliminate re-computating.
# todo: Make the word search N length, with the following algo:
# 	Assume the min word length is 5.
# 	Iterate from 5 to word.length
#	Check each word through each iteration
# todo: Make the list run in length order.

get "/:word" do
	permutations = params[:word].chars.to_a.permutation.map(&:join)
	permutations.each do |word|
		for word_len in 5..word.length
			word_segment = word[0..word_len-1]
			if dictionary[word_segment]
				found_words[word_segment] = true
			end
		end
	end
	# Reorder into length
	found_words.keys.sort_by(&:length).join("\n")
end

