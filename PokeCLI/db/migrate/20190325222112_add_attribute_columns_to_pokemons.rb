class AddAttributeColumnsToPokemons < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :speed, :integer
    add_column :pokemons, :special_defense, :integer
    add_column :pokemons, :special_attack, :integer
    add_column :pokemons, :defense, :integer
    add_column :pokemons, :attack, :integer
  end
end
