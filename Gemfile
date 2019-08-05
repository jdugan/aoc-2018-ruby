#----------------------------------------------
# gem sources
#----------------------------------------------

source 'http://rubygems.org'

ruby '2.6.3'


#----------------------------------------------
# common gems
#----------------------------------------------

# rails, etc.
gem 'rails',              '5.2.3'

# database
gem 'sqlite3'

# server
gem 'bootsnap'
gem 'puma'

# algorithms
gem 'dijkstra_graph'
gem 'shortest_path'


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
