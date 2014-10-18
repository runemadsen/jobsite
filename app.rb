require 'rubygems'
require 'bundler'
Bundler.require(:default, :assets, ENV["RACK_ENV"] || 'development')

set :root, File.dirname(__FILE__)

def production?
  ENV['RACK_ENV'] == 'production'
end

# App
# ----------------------------------------------

module Madsen
  class App < Sinatra::Base

    # Assets
    set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg)
    if production?
      set :assets_css_compressor, :scss
      set :assets_js_compressor, :uglifier
    else
      set :assets_digest, false
    end
    register Sinatra::AssetPipeline
    
    # Config
    set :sessions,
        :httponly     => true,
        :secure       => production?,
        :expire_after => 31557600,
        :secret       => ENV['SESSION_SECRET'] || 'abcdefg'

    # CSRF protection
    use Rack::Csrf, :raise => true

  end
end

# Initializers
# -----------------------------------------------------------

[
  "ROOT_URL",
  "ROOT_EMAIL",
  "SMTP_ADDRESS",
  "SMTP_PORT",
  "SMTP_USERNAME",
  "SMTP_PASSWORD"
].each { |var| raise "ENV['#{var}'] does not exist" unless !!ENV[var] }

# Helpers
# -----------------------------------------------------------

Dir["./helpers/*.rb"].each {|file| require file }
Madsen::App.helpers Madsen::Helpers::CSRF
Madsen::App.helpers Madsen::Helpers::Mail

# Routes
# -----------------------------------------------------------

Dir["./models/*.rb"].each {|file| require file }
Dir["./controllers/*.rb"].each {|file| require file }