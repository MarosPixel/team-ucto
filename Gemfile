source 'http://rubygems.org'

gem 'rails', '3.2.0'

gem 'jquery-rails'
gem 'haml-rails'
gem 'devise'
gem 'cancan'
gem 'simple_form'
gem 'acts_as_audited', '2.0.0'
gem 'will_paginate', '~> 3.0'

group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'closure-compiler' # gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg' # potrebne pre heroku
end

group :development do
  gem 'sqlite3'
  #gem 'eventmachine', '1.0.0.beta.4.1' # guard-livereload, vyzaduje -pre verziu pre ruby >= 1.9
  #gem 'guard-livereload'
end

group :test do
  gem 'sqlite3'
  gem 'turn', :require => false
end

