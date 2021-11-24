#----------------------------------------------
# gem sources
#----------------------------------------------

source 'http://rubygems.org'

ruby '3.0.0'


#----------------------------------------------
# common gems
#----------------------------------------------

# rails, etc.
gem 'rails',              '6.1.4.1'

# database
gem 'sqlite3'

# server
gem 'bootsnap'
gem 'puma'

# algorithms
# gem 'dijkstra_graph'


#----------------------------------------------
# environment gems
#----------------------------------------------

# development
group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

# local
group :development, :test do
  gem 'byebug',           platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end
