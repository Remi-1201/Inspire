source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '6.0.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave'
gem 'mini_magick'
gem 'mimemagic', '0.3.7'
gem 'image_processing'
gem 'kaminari'

# for login
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'rexml'
gem 'rails_admin', '~> 3.0'
gem 'cancancan'

# translate
gem 'rails-i18n'

# seed
gem 'faker'

# test
gem 'poltergeist'
gem 'pry-rails'

# aws
gem 'fog-aws'
gem "aws-sdk-s3", require: false 

gem 'ransack'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    # for rspec
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
  gem 'rexml'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
  # gem 'selenium-webdriver'は削除
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
