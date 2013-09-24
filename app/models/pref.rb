class Pref < ActiveRecord::Base
  attr_accessible :pref_id, :pref_name
  #has_one :weather
  has_one :getweather
end
