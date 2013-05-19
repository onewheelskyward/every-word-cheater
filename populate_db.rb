require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://localhost/everywordcheater')

require_relative 'models/dictionary_word'

# Also, copy dictionary_words (word) from './words';
File.open("words") do |file|
	file.each do |line|
		word = line.strip.downcase
		puts word
		#if word.length >= 5 and word.length <= 7
		DictionaryWord.create(:word => word)
		#end
	end
end
