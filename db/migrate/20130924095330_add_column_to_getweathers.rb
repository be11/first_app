class AddColumnToGetweathers < ActiveRecord::Migration
  def change
    add_column :getweathers, :sunrise, :datetime
  end
end
