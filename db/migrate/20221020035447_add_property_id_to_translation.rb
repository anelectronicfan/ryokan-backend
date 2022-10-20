class AddPropertyIdToTranslation < ActiveRecord::Migration[5.2]
  def change
    add_column :translations, :property_id, :integer
  end
end
