class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :pokemon_name
      t.string :image
      t.integer :pokemon_id
      t.integer :pokemon_index
      t.references :extension, null: false, foreign_key: true

      t.timestamps
    end
  end
end
