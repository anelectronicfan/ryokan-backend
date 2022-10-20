class AddCarspaceToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :carspace, :integer
  end
end
