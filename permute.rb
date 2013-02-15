require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://localhost/everywordcheater')

require_relative 'models'

before do
	content_type 'text/plain'
end

get %r{/(\w{5,7})} do |letters|
	puts "Letters: #{letters}"
	found_words = FoundWord.all(:letters => letters)
	if found_words.empty?
		puts "Found words empty"
		permutations = letters.chars.to_a.permutation.map(&:join)

		permutations.each do |word|
			for word_len in 5..word.length
				word_segment = word[0..word_len-1]
				unless (dict_word = DictionaryWord.first(:word => word_segment)).nil?
					FoundWord.first_or_create(:letters => letters, :dictionary_word => dict_word)
				end
			end
		end
		found_words = FoundWord.all(:letters => letters)
		permutations
	end

	returned_words = []
	found_words.each do |m|
		returned_words.push m.dictionary_word.word
	end
	#Reorder into length
	returned_words.sort_by(&:length).join("\n")
end

