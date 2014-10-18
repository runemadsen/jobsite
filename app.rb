# Require
# ----------------------------------------------

require 'rubygems'
require 'bundler'
Bundler.require(:default, :assets, ENV["RACK_ENV"] || 'development')

# Basic helpers
# ----------------------------------------------

def production?
  ENV['RACK_ENV'] == 'production'
end

# Initializers
# -----------------------------------------------------------

[
  "ROOT_URL",
  "ROOT_EMAIL",
  "DATABASE_URL",
  "SMTP_ADDRESS",
  "SMTP_PORT",
  "SMTP_USERNAME",
  "SMTP_PASSWORD"
].each { |var| raise "ENV['#{var}'] does not exist" unless !!ENV[var] }

# Configuration
# ----------------------------------------------

Dir["./config/*.rb"].each {|file| require file }

# App
# ----------------------------------------------

module Madsen
  class App < Sinatra::Base

    # --> Paths

    set :root, File.dirname(__FILE__)
    set :views, Proc.new { File.join(root, "app/views") }

    # --> Assets

    set :assets_prefix, %w(app/assets)
    set :assets_precompile, %w(application.js application.css *.png *.jpg *.svg)
    if production?
      set :assets_css_compressor, :scss
      set :assets_js_compressor, :uglifier
    else
      set :assets_digest, false
    end
    register Sinatra::AssetPipeline
    
    # --> Cookies

    set :sessions,
        :httponly     => true,
        :secure       => production?,
        :expire_after => 31557600,
        :secret       => ENV['SESSION_SECRET'] || 'abcdefg'

    # --> CSRF protection

    use Rack::Csrf, :raise => true

    # --> Errors
    
    error do
      "SOMETHING WENT WRONG!"
    end

  end
end

# Helpers
# -----------------------------------------------------------

Dir["./app/helpers/*.rb"].each {|file| require file }
Madsen::App.helpers Madsen::Helpers::CSRF
Madsen::App.helpers Madsen::Helpers::Mail

# Routes
# -----------------------------------------------------------

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/controllers/*.rb"].each {|file| require file }
Dir["./app/controllers/api/*.rb"].each {|file| require file }