# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'rails', '~> 7.1.3'
gem 'webrick', '~> 1.8'                         # Use WEBrick instead of Puma because it's single-threaded due to in-memory data storage requirements

gem 'tzinfo-data', platforms: %i[windows jruby] # Windows does not include zoneinfo files

gem 'bootsnap', require: false                  # Reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 6.1'
  gem 'rubocop-rails', '~> 2.23', require: false
  gem 'rubocop-rspec', '~> 2.26', require: false
end

group :development do
  gem 'spring'                                  # Spring speeds up development by keeping your application running in the background. Read more: https: //github.com/rails/spring
end
