class Request
	include DataMapper::Resource

	property :id, Serial
	property :param, String

	has n, :found_words
end
