class CLI
  require 'pry'
  attr_reader :user


  def welcome
    puts "Welcome to PokeCLI"
  end

  def who_are_you?
    puts "What's your name?"
    name = gets.chomp
    @user = User.find_or_create_by(name: name)
    @user.pokemons.count == 0 ? self.default_pokemon : self.menu
    binding.pry
  end

  def default_pokemon
    puts "Hello! My name is Oak. People call me the Pokeom Professor. So your name is #{@user.name}?"
    self.menu
  end

  def menu

  end

end
