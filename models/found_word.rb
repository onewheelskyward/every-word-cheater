class FoundWord
	include DataMapper::Resource

	property :id, Serial

	belongs_to :request
	belongs_to :dictionary_word
end
