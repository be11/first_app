class CreatePrefs < ActiveRecord::Migration
  def change
    create_table :prefs do |t|
      t.integer :pref_id
      t.string :pref_name

      t.timestamps
    end
  end
end
