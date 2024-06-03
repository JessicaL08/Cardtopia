class CreateExtensions < ActiveRecord::Migration[7.1]
  def change
    create_table :extensions do |t|
      t.string :extension_name
      t.string :extension_acronym
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
