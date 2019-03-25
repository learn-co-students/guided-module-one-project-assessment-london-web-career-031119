require_relative '../config/environment'

cli = CLI.new

system("clear")

cli.welcome
cli.who_are_you?


# this will run series of cli methods
