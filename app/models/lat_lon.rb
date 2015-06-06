class LatLon < Struct.new(:lat, :lon)
  def as_postgis
    "ST_MakePoint(#{lat.to_f}, #{lon.to_f})"
  end
end
