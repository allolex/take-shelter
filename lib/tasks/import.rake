namespace :import do
  # timestamp file of last import to enable dependency-driven rakes
  ts_f = "tmp/shelter-import"

  desc "import hurricane shelter data from miami-dade"
  task :shelter => ts_f

  file ts_f => %w{vendor/HurricaneShelter.shp vendor/HurricaneShelter.shx} do
    sh 'ogr2ogr -f "PostgreSQL" PG:"dbname=shelter-development" vendor/HurricaneShelter.shp -overwrite'
    sh "touch #{ts_f}"

  end
end
