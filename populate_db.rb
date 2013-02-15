require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://localhost/everywordcheater')

require_relative 'models'

File.open("words") do |file|
	file.each do |line|
		word = line.strip.downcase
		if word.length >= 5 and word.length <= 7
			DictionaryWord.create(:word => word)
		end
	end
end
