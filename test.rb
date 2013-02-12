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
		refute words.include?("deer")
		# But we should have 5,6 and 7.
		assert words.include?("rebed")
		assert words.include?("berate")
		assert words.include?("betread")
	end
end
