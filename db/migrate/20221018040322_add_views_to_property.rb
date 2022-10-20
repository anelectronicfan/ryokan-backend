class AddViewsToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :views, :integer
  end
end
