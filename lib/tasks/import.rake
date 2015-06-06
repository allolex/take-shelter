namespace :import do
  # timestamp file of last import to enable dependency-driven rakes
  shelter_ts = "tmp/shelter-import"
  zipcode_ts = "tmp/zipcode-import"

  dbname = TakeShelter::Application.config.database_configuration[Rails.env]['database']

  desc "import everything"
  task :all => %i(shelter zipcode)

  desc "import hurricane shelter data from miami-dade"
  task :shelter => shelter_ts

  file shelter_ts => %w{environment vendor/HurricaneShelter.shp vendor/HurricaneShelter.shx} do
    sh "ogr2ogr -f 'PostgreSQL' PG:'dbname=#{dbname}' vendor/HurricaneShelter.shx"
    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE hurricaneshelter SET wkb_geometry=ST_SetSRID(ST_Point(lon, lat), 900914);
      CREATE VIEW hurricaneshelters AS
        SELECT
          ogc_fid as id,
          wkb_geometry,
          folio,
          id as orig_id,
          name,
          address,
          city,
          zipcode,
          phone,
          fax,
          region,
          capacity,
          capacity15,
          type as orig_type,
          adacmpl,
          security,
          priority,
          lat,
          lon,
          point_x,
          point_y
        FROM hurricaneshelter;
    SQL
    sh "touch #{shelter_ts}"
  end

  desc "import zipcode data for miami dade"
  task :zipcode => zipcode_ts

  file zipcode_ts => ['vendor/Zipcode.json', 'environment'] do
    sh "ogr2ogr -f 'PostgreSQL' -select ZIPCODE PG:'dbname=#{dbname}' vendor/Zipcode.json -nln zipcode"
        ActiveRecord::Base.connection.execute <<-SQL
      CREATE VIEW zipcodes AS
        SELECT
          ogc_fid as id,
          ST_Centroid(wkb_geometry) as centroid,
          ST_X(ST_Centroid(wkb_geometry)) as lat,
          ST_Y(ST_Centroid(wkb_geometry)) as lon,
          zipcode
        FROM zipcode;
    SQL
    sh "touch #{zipcode_ts}"
  end

  desc "unimport everything"
  task :unimport => 'environment' do
    sh "rm -f tmp/*-import"
    ActiveRecord::Base.connection.execute <<-SQL
      DROP VIEW IF EXISTS hurricaneshelters;
      DROP VIEW IF EXISTS zipcodes;
      DROP TABLE IF EXISTS hurricaneshelter;
      DROP TABLE IF EXISTS zipcode;
    SQL
  end
end
