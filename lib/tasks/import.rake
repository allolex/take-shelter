namespace :import do
  # timestamp file of last import to enable dependency-driven rakes
  ts_f = "tmp/shelter-import"

  desc "import hurricane shelter data from miami-dade"
  task :shelter => ts_f

  file ts_f => %w{environment vendor/HurricaneShelter.shp vendor/HurricaneShelter.shx} do
    sh 'ogr2ogr -f "PostgreSQL" PG:"dbname=shelter-development" vendor/HurricaneShelter.shx'
    ActiveRecord::Base.connection.execute <<-SQL
      UPDATE hurricaneshelter SET wkb_geometry=ST_SetSRID(ST_Point(lon, lat), 900914);
    SQL
    sh "touch #{ts_f}"

  end
end
