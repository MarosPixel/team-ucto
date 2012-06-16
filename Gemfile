source 'http://rubygems.org'

gem 'rails', '3.2.6'

gem 'jquery-rails'
gem 'haml-rails'
gem 'devise'
gem 'cancan'
gem 'simple_form'
gem 'acts_as_audited', '2.0.0'
gem 'will_paginate', '~> 3.0'
# gem 'rubyzip' # nevie otvarat zaheslovane zipy
gem 'zipruby' # nesiel nainstalovat pre windows

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'closure-compiler' # gem 'uglifier', '>= 1.2.4'
  # gem 'bourbon'
  # gem 'compass-rails'

  gem 'therubyracer'
end

group :production do
  gem 'pg' # potrebne pre heroku
end

group :development do
  gem 'sqlite3'
  # gem 'eventmachine', '1.0.0.beta.4.1' # guard-livereload, vyzaduje -pre verziu pre ruby >= 1.9
  # gem 'guard-livereload'
  gem 'turn', require: false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# sudo service nginx restart && cd /vagrant && bundle exec unicorn -c /vagrant/config/unicorn.rb -D