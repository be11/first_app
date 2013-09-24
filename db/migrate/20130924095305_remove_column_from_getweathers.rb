class RemoveColumnFromGetweathers < ActiveRecord::Migration
  def up
    remove_column :getweathers, :sunrize
  end

  def down
    add_column :getweathers, :sunrize, :datetime
  end
end
