# A class to abstract a latitude and longitude, to prevent swapping the two
# fields.
class LatLon < Struct.new(:lat, :lon)
  def as_postgis
    "ST_MakePoint(#{lat.to_f}, #{lon.to_f})"
  end
end
