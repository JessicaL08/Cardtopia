class CreateSeasons < ActiveRecord::Migration[7.1]
  def change
    create_table :seasons do |t|
      t.string :season_name
      t.string :season_acronym


      t.timestamps
    end
  end
end
