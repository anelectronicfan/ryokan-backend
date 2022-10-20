class AddContactToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :contact, :string
  end
end
