require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

# desc 'run app'
# task :cli do
#   cli = CLI.new
#   cli.run_my_app
# end
