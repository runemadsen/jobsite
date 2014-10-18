source 'https://rubygems.org'

gem 'unicorn', '~> 4.8.3'
gem 'sinatra', '~> 1.4.5'
gem 'sinatra-asset-pipeline', '~> 0.5.0', :require => 'sinatra/asset_pipeline'
gem 'uglifier', '~> 2.5.3'
gem 'rack_csrf', '~> 2.5.0', :require => 'rack/csrf'
gem 'pony', '~> 1.11'
gem 'sequel', '~> 4.15.0'
gem 'pg', '~> 0.17.1'

group :assets do
  gem 'bourbon', '~> 4.0.2'
  gem 'neat', '~> 1.7.0'
  gem 'bitter', '~> 0.0.1'
end

group :development do
  gem 'shotgun'
	gem 'thin'
  gem 'mailcatcher', '~> 0.5.12', :require => false
end

group :test do
  gem 'dotenv', '~> 1.0.2'
  gem 'rspec', '~> 3.1.0'
  gem 'database_cleaner', '~> 1.3.0'
end