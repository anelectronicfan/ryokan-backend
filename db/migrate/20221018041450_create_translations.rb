class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      t.string :address
      t.string :transport
      t.string :description
      t.string :notes
      t.string :property_type

      t.timestamps
    end
  end
end
