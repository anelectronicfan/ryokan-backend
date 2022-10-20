class AddBedroomToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :bedroom, :integer
  end
end
