require_relative 'permute'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class PermuteTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Sinatra::Application
	end

	def test_it_permutes
		get '/abdeert'
		assert last_response.ok?
		words = last_response.body.split /\n/
		# We shouldn't have the four letter words.
		refute words.include?("deer"), "Deer was found in the results and has too few letters."
		# But we should have 5,6 and 7.
		assert words.include?("rebed"), "rebed was not found in the results."
		assert words.include?("berate"), "berate was not found in the results."
		assert words.include?("betread"), "betread was not found in the results."
	end
end
