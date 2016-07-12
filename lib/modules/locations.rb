module Locatable
  def Locatable.included other
    other.extend Locatable::ClassMethods
  end

  module ClassMethods
    def closest_to(lat, long)
      station_corrilation = {}
      self.all.each do |station|
     station_corrilation[station] = (Haversine.distance(station.latitude, station.longitude, lat, long).to_miles)
      end
      station_corrilation =  station_corrilation.sort_by{ |k,v| v}
      return station_corrilation.first.first
    end
  end

  def distance_to(lat, long)
    distance = Haversine.distance(self.latitude, self.longitude, lat, long)
    distance.to_miles
  end


end



class Station
  attr_reader :latitude, :longitude

  include Locatable

  def initialize lat, long
    @latitude, @longitude = lat, long
  end

  def self.all
    [
      Station.new(12, -36),
      Station.new(10, -33),
      Station.new(77,  45)
    ]
  end
end
