require 'json'
require 'open-uri'
require 'date'

class Weather
  URL_W = "http://api.openweathermap.org/data/2.5/weather?"
  URL_F = "http://api.openweathermap.org/data/2.5/forecast?"
  MTR = "&units=metric"
  OK = 200

  def initialize(args)
    if args.key?(:place) && args[:place].is_a?(String)
      @path = "q=#{args[:place].downcase.gsub(/\s+/, "")}"
    elsif args.key?(:lat) && args.key?(:lon)
      @path = "lat=#{args[:lat]}&lon=#{args[:lon]}"
    elsif args.key?(:id)
      @path = "id=#{args[:id]}"
    else
      raise "unknown keyword or too many keywords or too few keywords"
    end
    #raise "invalid parameter" unless url_correct?
  end

  def get
    @data = JSON.parser.new(open(URL_W+@path+MTR).read).parse()
    raise "invalid address" unless data_correct?(@data)
  end

  def fc_get(date)
    @fdata = JSON.parser.new(open(URL_F+@path+MTR).read).parse()
    if data_correct?(@fdata)
      @fdata = @fdata["list"].delete_if{|x|
      DateTime.parse(date) > DateTime.parse(x["dt_txt"]) || DateTime.parse(x["dt_txt"]) >= DateTime.parse(date)+1}
      raise "invalid date" if @fdata.empty?
    else
      raise "invalid address"
    end
  end

  def method_missing(id)
   begin
     data = Array.new
     if (param = id.to_s)=~ /^fc_/
       @fdata.each do |i|
        d = i
        param.sub(/^fc_/, '').gsub(/__/," ").split(/_/).each {|j| d = (j =~ /[0-9]/) ? d[j.to_i] : d[j.gsub(/\s/, "_")]}
        super unless d
        data.push(i["dt_txt"].split.last, d)
       end
     else
       data = @data
       param.gsub(/__/, " ").split(/_/).each {|i| data = (i =~ /[0-9]/) ? data[i.to_i] : data[i.gsub(/\s/, "_")]}
       super unless data
     end
   rescue super
   end
   data
  end

  def url_correct?
    if @path =~ /^lat=-?(90|([0-9]|[1-8][0-9])(\.[0-9]+)?)&lon=-?(180|([0-9]|[1-9][0-9]|1[0-7][0-9])(\.[0-9]+)?)$|(^q=[a-z]+,[a-z]+$)|(^id=[0-9]+$)/
    return true
    end
    return false
  end

  def data_correct?(data)
    if data.is_a?(Hash) && data["cod"].to_i != OK
      return false
    end
    return true
  end
end
w = Weather.new(:place => "sapporo,JP")
w.get
p "lon"
p w.coord_lon
p "description"
p w.weather_0_description
p "weather"
puts w.weather
w.fc_get((Date.today+1).strftime("%d"))
p "pressure"
p w.fc_main_pressure
p "hum"
p w.fc_main_humidity
p "temp max"
p w.fc_main_temp__max
p "speed"
p w.fc_main_speed
