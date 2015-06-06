class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :body
      t.string :from
      t.string :to
      t.string :account_sid
      t.string :message_sid
      t.references :caller, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
