source 'https://rubygems.org'
ruby '2.3.3'

gem 'rails', '~>4.1.8'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '3.1.1'
gem 'turbolinks', '~> 2.5.3'
gem 'devise', '~> 3.5.10'
gem 'figaro', '1.1.1'
gem 'foundation-rails', '5.3.1.0'
gem 'haml-rails', '~> 0.9'
gem 'pg', '~> 0.19.0'
gem 'puma', '~> 3.6.2'
gem 'sidekiq', '~> 3.5.4'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'spring', '1.1.3'
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'faker'
  gem 'shoulda-matchers', require: false
end
