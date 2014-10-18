require 'rubygems'
require 'bundler'
Bundler.require(:default, :assets, ENV["RACK_ENV"] || 'development')

set :root, File.dirname(__FILE__)

# App
# ----------------------------------------------

module Madsen
  class App < Sinatra::Base

    # Assets
    set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg)
    set :assets_css_compressor, :scss
    set :assets_js_compressor, :uglifier
    register Sinatra::AssetPipeline
    
    # Config
    set :sessions,
        :httponly     => true,
        :secure       => ENV['RACK_ENV'] == 'production',
        :expire_after => 31557600,
        :secret       => ENV['SESSION_SECRET'] || 'abcdefg'

    # CSRF protection
    use Rack::Csrf, :raise => true

  end
end

# Helpers
# -----------------------------------------------------------

Dir["./helpers/*.rb"].each {|file| require file }
Madsen::App.helpers Madsen::Helpers::CSRF

# Routes
# -----------------------------------------------------------

Dir["./models/*.rb"].each {|file| require file }
Dir["./controllers/*.rb"].each {|file| require file }