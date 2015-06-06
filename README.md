# take-shelter

## database configuration and entities

This project depends on PostgreSQL and PostGIS. The import scripts produce two
tables and two views.

* Table `zipcode`: a relatively simple import from geojson available from
http://gis.mdc.opendata.arcgis.com/datasets/3815768dd1c84f429b1d8a76c44e9bc3_0
* Table `hurricaneshelter`: an import from
http://gisweb.miamidade.gov/GISSelfServices/GeographicData/MDGeographicData.html
but with the wkb_geometry column re-set to a more sensible SRID.
* View `zipcodes`: a rails-friendly version of the `zipcode` table, with a
centroid instead of a huge polygon to save bandwidth.
* View `hurricaneshelters`: a rails-friendly version of the `hurricaneshelter`
table, with renamed fields.

## importing data from a postgresql custom dump

```ruby
pg*restore --verbose  --no-acl --no-owner --clean -d shelter-development DUMPNAME.dump
```

## importing data from files/first principles

This process creates the `hurricaneshelter` table, which is why it doesn't have
a migration.

1. Have postgresql, postgis, and gdal with postgres support installed.
`brew install gdal --with-postgres; brew install postgis` does this on Mac with
Homebrew.
2. `rake db:create db:migrate` if you haven't created the database already.
3. `rake import:all`
