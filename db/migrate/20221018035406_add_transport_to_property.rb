class AddTransportToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :transport, :string
  end
end
