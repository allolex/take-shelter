class Zipcode < ActiveRecord::Base
  def as_latlon
    LatLon.new.tap do |ll|
      ll.lat = lat
      ll.lon = lon
    end
  end
end
