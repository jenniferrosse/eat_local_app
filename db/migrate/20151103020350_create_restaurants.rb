class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :url
      t.string :menu

      t.timestamps
    end
  end
end
