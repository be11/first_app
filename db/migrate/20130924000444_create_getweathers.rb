class CreateGetweathers < ActiveRecord::Migration
  def change
    create_table :getweathers do |t|
      t.float :lon
      t.float :lat
      t.datetime :sunrize
      t.datetime :sunset
      t.string :description
      t.float :temp
      t.float :pressure
      t.float :humidity
      t.float :temp_min
      t.float :temp_max
      t.float :windspeed
      t.float :clouds
      t.integer :pref_id
      t.datetime :get_time

      t.timestamps
    end
  end
end
