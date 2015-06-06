class ConfigurePostgis < ActiveRecord::Migration
  def up
    enable_extension 'postgis'
  end

  def down
    ActiveRecord::Base.connection.execute <<-SQL
      DELETE FROM spatial_ref_sys WHERE srid=102658;
    SQL
    disable_extension 'postgis'
  end
end
