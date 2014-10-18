ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'dotenv'
Dotenv.load
require_relative '../app.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app() Madsen::App end
end

RSpec.configure { |c| 
  c.include RSpecMixin
  c.color = true

  c.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  c.before(:each) do |example|
    allow(Pony).to receive(:deliver) { true }
  end

  c.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
}

def last_json
  @json ||= JSON.parse(last_response.body)
end