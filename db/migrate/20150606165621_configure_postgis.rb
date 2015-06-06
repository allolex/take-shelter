class ConfigurePostgis < ActiveRecord::Migration
  def up
    enable_extension 'postgis'
  end

  def down
    disable_extension 'postgis'
  end
end
