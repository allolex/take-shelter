namespace :import do
  # timestamp file of last import to enable dependency-driven rakes
  shelter_ts = "tmp/shelter-import"
  zipcode_ts = "tmp/zipcode-import"

  desc "import hurricane shelter data from miami-dade"
  task :shelter => shelter_ts

  file shelter_ts => %w{environment vendor/HurricaneShelter.shp vendor/HurricaneShelter.shx} do
    sh 'ogr2ogr -f "PostgreSQL" PG:"dbname=shelter-development" vendor/HurricaneShelter.shx'
    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE hurricaneshelter SET wkb_geometry=ST_SetSRID(ST_Point(lon, lat), 900914);
    SQL
    sh "touch #{shelter_ts}"
  end

  desc "import zipcode data for miami dade"
  task :zipcode => zipcode_ts

  file zipcode_ts => 'vendor/Zipcode.json' do
    sh 'ogr2ogr -f "PostgreSQL" -select ZIPCODE PG:"dbname=shelter-development" vendor/Zipcode.json -nln zipcode'
    sh "touch #{zipcode_ts}"
  end
end
