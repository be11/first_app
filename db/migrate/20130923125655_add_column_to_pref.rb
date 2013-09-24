class AddColumnToPref < ActiveRecord::Migration
  def change
    add_column :prefs, :pref_name_en, :string
  end
end
