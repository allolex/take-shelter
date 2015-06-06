class Hurricaneshelter < ActiveRecord::Base
  def self.distance_order(lat_lon)
    order("ST_Distance(ST_SetSRID(#{lat_lon.as_postgis}, 900914), wkb_geometry) DESC")
  end

  def self.by_zipcode(zip)
    unless zip.is_a? Zipcode
      # will puke if the zip is neither numeric or string, i'm okay with that
      zip.gsub!(/\-.+/,'') unless zip.is_a? Numeric
      zip = Zipcode.find_by zipcode: zip
    end

    distance_order zip.as_latlon
  end

  def as_latlon
    LatLon.new.tap do |ll|
      ll.lat = lat
      ll.lon = lon
    end
  end
end
