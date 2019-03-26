require 'pry'
class Battle
  attr_reader :user_pokemon, :team_rocket_pokemon
  attr_accessor :user, :array_of_attributes, :user_score, :tr_score

  def initialize(user, user_pokemon, team_rocket_pokemon)
    @user = user
    @user_pokemon = user_pokemon
    @team_rocket_pokemon = team_rocket_pokemon
    @array_of_attributes = ["speed", "special_defense", "special_attack", "defense", "attack"]
    @user_score = 0
    @tr_score = 0
  end

  def round_1
    puts "Jesus! That looks like a #{team_rocket_pokemon.name}! It looks angry - which attribute do you want to use?!"
    @array_of_attributes.each {|attribute| puts "#{attribute}" }
    user_choice = gets.chomp

    if @user_pokemon.send(:"#{user_choice}") > @team_rocket_pokemon.send(:"#{user_choice}")
      puts "You used #{user_choice} with #{@user_pokemon.send(:"#{user_choice}")} damage!"
      puts "Good job! I think you hurt it!"
      @user_score += 1
      puts "You need to win one more round to win the battle!"
    else
      puts "Team Rocket used #{user_choice} with #{@team_rocket_pokemon.send(:"#{user_choice}")} damage!"
      puts "Ouch - their #{@team_rocket_pokemon.name} was too strong for you, be careful!"
      @tr_score += 1
      puts "Team Rocket won the round - if they win the next one, they'll win the battle!"
    end

    @array_of_attributes.delete(user_choice)
    self.round_2
  end

  def round_2
    tr_choice = @array_of_attributes.sample
    puts "It's Team Rocket's turn to attack! They used #{tr_choice}!"
    if @user_pokemon.send(:"#{tr_choice}") > @team_rocket_pokemon.send(:"#{tr_choice}")
      puts "Your #{@user_pokemon.name} is stronger with #{@user_pokemon.send(:"#{tr_choice}")} damage!"
      puts "Good job! I think you hurt it!"
      @user_score += 1
    else
      puts "Team Rocket used #{tr_choice} with #{@team_rocket_pokemon.send(:"#{tr_choice}")} damage!"
      puts "Their #{@team_rocket_pokemon.name} was too strong for you, be careful!"
      @tr_score += 1
    end
    @array_of_attributes.delete(tr_choice)
    self.check_score
  end

  def round_3
    puts "Which attribute do you want to use?! Choose carefully!"
    @array_of_attributes.each {|attribute| puts "#{attribute}" }
    user_choice = gets.chomp

    if @user_pokemon.send(:"#{user_choice}") > @team_rocket_pokemon.send(:"#{user_choice}")
      puts "You used #{user_choice} with #{@user_pokemon.send(:"#{user_choice}")} damage!"
      puts "Good job! I think you hurt it!"
      @user_score += 1
    else
      puts "Team Rocket used #{user_choice} with #{@team_rocket_pokemon.send(:"#{user_choice}")} damage!"
      puts "Ouch - their #{@team_rocket_pokemon.name} was too strong for you, be careful!"
      @tr_score += 1
    end
    self.check_score
  end

  def check_score
    if @user_score == 2
      puts "Congrats! You managed to beat Team Rocket and catch their #{@team_rocket_pokemon.name}!
      Check your Pokedex at the main menu - you can also use this #{@team_rocket_pokemon.name} in your next battle."
      UserPokemon.create({user: @user, pokemon: @team_rocket_pokemon})
    elsif @tr_score == 2
      puts "Team Rocket were too strong for you! Better luck next time!"
      if @user.pokemons.count > 1
        UserPokemon.find_by(user: @user).destroy
        puts "Team Rocket took your and took your #{@user_pokemon.name}!"
      else
      puts "You've only got one pokemon left - Team Rocket decided to let you keep it."
      end
    else
      puts "Get ready - this is the final round!"
      self.round_3
    end
  end

end
