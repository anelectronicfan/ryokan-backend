class AddVacantLotToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :vacant_lot, :boolean
  end
end
