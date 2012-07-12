class CreateMerchantLocations < ActiveRecord::Migration
  def change
    create_table :merchant_locations do |t|
      t.string :latitude
      t.string :longitude
      t.text :address
      t.string :contact
      t.string :contact_person
      t.string :email
      t.references :city
      t.references :area
      t.references :merchant
      t.references :category

      t.timestamps
    end
    add_index :merchant_locations, :city_id
    add_index :merchant_locations, :area_id
    add_index :merchant_locations, :merchant_id
    add_index :merchant_locations, :category_id
  end
end
