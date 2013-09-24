class RemoveColumnFromWeather < ActiveRecord::Migration
  def up
    remove_column :weathers, :city
  end

  def down
    add_column :weathers, :city, :string
  end
end
