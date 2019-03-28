require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'Start a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc 'Run the app'
task :run do
  cli =  CLI.new
  cli.start
end
