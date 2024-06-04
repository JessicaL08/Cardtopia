class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :pokemon_name
      t.string :pokemon_id
      t.string :pokemon_index
      t.string :category
      t.string :rarity
      t.string :image
      t.jsonb :metadata, default: {}

      t.references :extension, null: false, foreign_key: true

      t.timestamps
    end
  end
end
