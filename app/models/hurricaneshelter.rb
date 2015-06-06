class Hurricaneshelter < ActiveRecord::Base
  def self.distance_order(lat_lon)
    order("ST_Distance(ST_SetSRID(#{lat_lon.as_postgis}, 900914), wkb_geometry) DESC")
  end
end
