# A class to abstract a latitude and longitude, to prevent swapping the two
# fields.
class LatLon < Struct.new(:lat, :lon)
  def self.centroid(collection)
    lat_centroid = collection.map(&:lat).sum / collection.length
    lon_centroid = collection.map(&:lon).sum / collection.length

    new.tap do |ll|
      ll.lat = lat_centroid
      ll.lon = lon_centroid
    end
  end

  def as_postgis
    "ST_MakePoint(#{lat.to_f}, #{lon.to_f})"
  end

  def to_s
    [lat_s, lon_s].join ', '
  end

  def to_marker
    [lat, lon].join ','
  end

  def lat_s
    [
      lat.abs.round(5),
      (lat > 0 ? 'N' : 'S')
    ].join ' '
  end

  def lon_s
    [
      lon.abs.round(5),
      (lon > 0 ? 'E' : 'W')
    ].join ' '
  end
end
