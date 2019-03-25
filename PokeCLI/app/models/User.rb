class User < ActiveRecord::Base
  has_many :user_pokemons
  has_many :pokemons, through: :user_pokemons
end
