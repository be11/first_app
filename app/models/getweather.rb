class Getweather < ActiveRecord::Base
  attr_accessible :clouds, :description, :get_time, :humidity, :lat, :lon, :pref_id, :pressure, :sunrize, :sunset, :temp, :temp_max, :temp_min, :windspeed
end
