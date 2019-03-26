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
    choice = gets.chomp.to_i
    case choice
    when 1
      UserPokemon.create({user: @user, pokemon: Pokemon.find_by(name: "Bulbasaur")})
    when 2
      UserPokemon.create({user: @user, pokemon: Pokemon.find_by(name: "Squirtle")})
    when 3
      UserPokemon.create({user: @user, pokemon: Pokemon.find_by(name: "Charmander")})
    when 4
      UserPokemon.create({user: @user, pokemon: Pokemon.find_by(name: "Pikachu")})
    end
    self.menu
  end

  def menu
    puts "Welcome to the Main Menu. Press 1 to do battle!"
    choice = gets.chomp.to_i
    case choice
    when 1
      self.battle
    end
  end


    def select_pokemon
      puts "Woah - I think I saw Team Rocket up ahead! Quick - select your pokemon for battle!"
      @user.pokemons.all.each {|pokemon| puts "#{pokemon.name}"}
      puts "Type the name of the pokemon you select."
      choice = gets.chomp
      user_pokemon = Pokemon.find_by(name: choice)
      puts "Great! You chose #{user_pokemon.name}! Let's get ready!"
      user_pokemon
    end

    def random_pokemon
      Pokemon.order("RANDOM()").first
    end

    def battle
      user_pokemon = select_pokemon
      team_rocket_pokemon = random_pokemon
      new_battle = Battle.new(user_pokemon, team_rocket_pokemon)
    end


end
