class CreateAlbumPokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :album_pokemons do |t|
      t.references :album, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
