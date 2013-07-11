source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'bootstrap-sass', '~> 2.3.2.0'
gem 'bcrypt-ruby', '~> 3.1.0'
gem 'faker', '~> 1.1.2'
gem 'will_paginate', '~> 3.0.4'
gem 'bootstrap-will_paginate', '~> 0.0.9'
gem 'jquery-rails', '~> 3.0.1'
gem 'turbolinks', '~> 1.2.0'

gem 'sass-rails', '~> 4.0.0.beta1'
gem 'coffee-rails', '~> 4.0.0.beta1'
gem 'uglifier', '~> 2.1.1'

gem 'coveralls', require: false
gem 'newrelic_rpm', '~> 3.6.5.130'
gem 'devise', '~> 3.0.0.rc'
gem 'cancan', '~> 1.6.10'

group :development, :test do
  gem 'sqlite3', '~> 1.3.7'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'guard-rspec', '~> 3.0.2'
  gem 'guard-spork', '~> 1.5.0'  
  gem 'childprocess', '~> 0.3.6'
  gem 'spork', '~> 0.9.2'
end

group :test do
  gem 'capybara', '~> 2.1.0'
  gem 'factory_girl_rails', '~> 4.2.1'
  # gem 'cucumber-rails', '~> 1.3.1', :require => false
  gem 'database_cleaner', '~> 1.0.1'
  # gem 'launchy', '2.1.0'
  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
  gem 'shoulda-matchers', '~> 2.2.0'
end

group :production do
  gem 'pg', '~> 0.15.1'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end
