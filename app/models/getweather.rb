# -*- coding: undecided -*-
class Getweather < ActiveRecord::Base
  
  #クラス名がよくない
  #モデルはDBそのものを表すためにmodel名はWeatherとすべき
  #http://d.hatena.ne.jp/jyouji1979/20110521/1305998761

  attr_accessible :clouds, :description, :get_time, :humidity, :lat, :lon, :pref_id, :pressure, :sunrize, :sunset, :temp, :temp_max, :temp_min, :windspeed
end
