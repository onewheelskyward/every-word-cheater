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
		assert_equal 'Hello World', last_response.body
	end
end