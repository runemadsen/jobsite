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
}