class AddBuildDateToProperty < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :build_date, :date
  end
end
