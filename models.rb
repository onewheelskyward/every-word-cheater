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

