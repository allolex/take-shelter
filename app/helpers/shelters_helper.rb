module SheltersHelper
  def static_map(shelters)
    latlons = shelters.map(&:as_latlon)
    centroid = LatLon.centroid latlons
    markers = latlons.map(&:to_marker)
    q = {markers: markers.join('|'),
              center: centroid.to_marker,
              zoom: 12}.to_query
    uri = "http://staticmap.openstreetmap.de/staticmap.php?#{q}"
#    return ur#
    image_tag uri
  end
end
