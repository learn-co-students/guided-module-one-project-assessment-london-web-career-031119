require 'pry'

def populate_pokemons_table
  # url = 'https://pokeapi.co/api/v2/generation/1/'
  url = 'https://pokeapi.co/api/v2/pokemon/'
  response = RestClient.get(url)
  pokeinfo = JSON.parse(response)
  # pokeinfo["results"].each {|pokemon|
  #   Pokemon.create ({name: pokemon["name"]}
  # pokeinfo["pokemon_species"].each {|i| Pokemon.create(name: i["name"])}
  new_poke = Pokemon.create(name: pokeinfo["results"][0]["name"])
  url = pokeinfo["results"][0]["url"]
  response = RestClient.get(url)
  pokeinfo = JSON.parse(response)

  new_poke.speed = pokeinfo["stats"][0]["base_stat"]
  new_poke. special_defense = pokeinfo["stats"][1]["base_stat"]
  new_poke.special_attack = pokeinfo["stats"][2]["base_stat"]
  new_poke.defense = pokeinfo["stats"][3]["base_stat"]
  new_poke.attack = pokeinfo["stats"][4]["base_stat"]

binding.pry
"Done!"
end

populate_pokemons_table
