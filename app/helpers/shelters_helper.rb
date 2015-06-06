module SheltersHelper
  def static_map(shelters)
    latlons = shelters.map(&:as_latlon)
    centroid = LatLon.centroid latlons
    markers = latlons.map(&:to_marker)
    params = {markers: markers,
              center: centroid.to_marker,
              zoom: 2}.to_query
    uri = "http://staticmap.openstreetmap.de/staticmap.php?#{params}"
    image_tag uri
  end
end
