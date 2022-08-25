class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :price
      t.integer :size
      t.string :description
      t.string :date_listed

      t.timestamps
    end
  end
end
