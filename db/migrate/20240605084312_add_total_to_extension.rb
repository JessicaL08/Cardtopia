class AddTotalToExtension < ActiveRecord::Migration[7.1]
  def change
    add_column :extensions, :total, :integer
  end
end
