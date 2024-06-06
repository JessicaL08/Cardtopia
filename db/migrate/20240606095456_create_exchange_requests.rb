class CreateExchangeRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :exchange_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true
      t.string :postal_code
      t.boolean :reserved

      t.timestamps
    end
  end
end
