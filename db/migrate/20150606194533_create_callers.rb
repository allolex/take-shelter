class CreateCallers < ActiveRecord::Migration
  def change
    create_table :callers do |t|
      t.string :phone
      t.string :language

      t.timestamps null: false
    end
  end
end
