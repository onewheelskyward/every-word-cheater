class Permutation
	include DataMapper::Resource

	property :id, Serial
	property :word, String
	property :checked, Boolean, default: false

	belongs_to :request
end
