require 'pry'

def populate_pokemons_table
  url = 'https://pokeapi.co/api/v2/generation/1/'
  response = RestClient.get(url)
  pokeinfo = JSON.parse(response)
  pokeinfo["pokemon_species"].each {|i| Pokemon.create(name: i["name"])}

binding.pry
"Done!"
end

populate_pokemons_table
