source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.3'
gem 'puma', '~> 4.3'

gem 'bootstrap'
gem 'jquery-rails'
gem 'popper_js'
gem 'uglifier'

gem 'carrierwave'
gem 'fog-aws'
gem 'rmagick'

gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'

gem 'pundit', '~> 1.1'
gem 'pundit-matchers', '~> 1.6.0'
gem 'resque', '~> 1.27'

gem 'devise-i18n'
gem 'rails-i18n'

gem 'dotenv-rails'

group :test do
  gem 'factory_bot_rails'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'sqlite3'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-resque', '~> 0.2.3', require: false

  gem 'letter_opener'

  gem 'listen'
  gem 'web-console'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
