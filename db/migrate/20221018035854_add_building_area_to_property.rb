class AddBuildingAreaToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :building_area, :decimal
  end
end
