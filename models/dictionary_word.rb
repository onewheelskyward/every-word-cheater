class DictionaryWord
	include DataMapper::Resource

	property :id, Serial
	property :word, String, index: true

	has n, :found_words
end
