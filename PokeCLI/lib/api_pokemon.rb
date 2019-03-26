require 'pry'
require_relative '../lib/pokemon_collection.rb'

def populate_pokemons_table
  Pokemon.destroy_all
  pokeinfo = JSON.parse(Pokemons::POKEMON)
  pokeinfo.each {|pokemon|
    Pokemon.create ({
      name: pokemon["name"].capitalize,
      speed: pokemon["stats"][4]["value"],
      special_defense: pokemon["stats"][0]["value"],
      special_attack: pokemon["stats"][1]["value"],
      defense: pokemon["stats"][2]["value"],
      attack: pokemon["stats"][3]["value"]
    })}
end
