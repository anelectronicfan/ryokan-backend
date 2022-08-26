class AddUrlToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :url, :string
  end
end
