class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :user, foreign_key: true
      t.string :ip_address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
