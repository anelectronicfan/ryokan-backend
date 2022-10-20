class AddBathroomToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :bathroom, :integer
  end
end
