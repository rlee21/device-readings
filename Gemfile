# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'bootsnap', require: false                  # Reduces boot times through caching; required in config/boot.rb
gem 'rails', '~> 7.1.3'
gem 'rswag-api', '~> 2.13'
gem 'rswag-ui', '~> 2.13'
gem 'tzinfo-data', platforms: %i[windows jruby] # Windows does not include zoneinfo files
gem 'webrick', '~> 1.8'                         # Use WEBrick instead of Puma because it's single-threaded due to in-memory data storage requirements

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails', '~> 2.8'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 6.1'
  gem 'rswag-specs', '~> 2.13'
  gem 'rubocop-rails', '~> 2.23', require: false
  gem 'rubocop-rspec', '~> 2.26', require: false
end

group :development do
  gem 'spring'                                  # Spring speeds up development by keeping your application running in the background. Read more: https: //github.com/rails/spring
end
