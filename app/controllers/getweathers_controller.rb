# -*- coding: utf-8 -*-
require 'getweather2.rb'
#requireでライブラリをもつなら、lib以下にライブラリを移動すべき
require 'date'

class GetweathersController < ApplicationController
  #定数は分離せよ
  
  Dev = 48
  #定数なのに2文字目が小文字なのはダメ
  PARAM = {lon: "coord_lon", lat: "coord_lat", temp: "main_temp", pressure: "main_pressure", humidity: "main_humidity", temp_min: "main_temp__min", temp_max: "main_temp__max", windspeed: "wind_speed", clouds: "clouds_all"}
  PARAM_TIME = { sunrise: "sys_sunrise", sunset: "sys_sunset", get_time: "dt"}

  def show
    unless @wdata = Pref.find_by_pref_id(params[:pref][:id]).getweather
      create_data
    else
      if !@wdata.lon || DateTime.now > @wdata.get_time.to_datetime + Rational(1, Dev)
        update_data
      end
    end
    @param = PARAM
    @tparam = PARAM_TIME
    @pref = Pref.find_by_pref_id(params[:pref][:id]).pref_name
  end

  #インデントがおかしい
  #_dataというメソッドは助長
  #def getとすべき
  def get_data
    w = Weather.new(:place => Pref.find_by_pref_id(params[:pref][:id]).pref_name_en + ",JP")
    w.get
    return w
  end
	
  #インデントがおかしい
  #def createとすべき
  def create_data
    @wdata = Getweather.create(:pref_id => params[:pref][:id])
    update_data
  end
  
  #def updateとすべき
  def update_data
    data = get_data
    PARAM.each do |k, v|
      @wdata.update_attribute(k, data.send(v))
    end
    PARAM_TIME.each do |k, v|
      @wdata.update_attribute(k, Time.at(data.send(v).to_i))
    end
  end

  #以下不要
  def get
  end
end
