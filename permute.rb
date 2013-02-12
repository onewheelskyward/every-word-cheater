require 'sinatra'
require 'data_mapper'
require 'dm-sqlite-adapter'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')

class DictionaryWord
	include DataMapper::Resource

	property :id, Serial
	property :word, String

	has n, :found_words
end

class FoundWord
	include DataMapper::Resource

	property :id, Serial
	property :letters, String

	belongs_to :dictionary_word
end

DataMapper.finalize
DataMapper.auto_upgrade!

File.open("words") do |file|
	file.each do |line|
		word = line.strip.downcase
		if word.length >= 5 and word.length <= 7
			DictionaryWord.create(:word => word)
		end
	end
end

before do
	content_type 'text/plain'
end

get %r{/(\w{5,7})} do |letters|
	found_words = FoundWord.all(:letters => letters)
	if found_words.empty?
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
	end

	returned_words = []
	found_words.each do |m|
		returned_words.push m.dictionary_word.word
	end
	# Reorder into length
	returned_words.sort_by(&:length).join("\n")
end

