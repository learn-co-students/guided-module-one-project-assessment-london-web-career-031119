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
  end

  def default_pokemon
    puts "Hello! My name is Oak. People call me the Pokemon Professor. So your name is #{@user.name}?"
    puts "I see you don't have any Pokemon with you. Well, I've had a few new ones come in just today - would you like to see?"
    puts "Please select your Pokemon"
    puts "1. Bulbasaur"
    puts "2. Squirtle"
    puts "3. Charmander"
    puts "4. Pikachu"
    self.menu
  end

  def menu

  end

end
