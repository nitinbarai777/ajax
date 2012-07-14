class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :price
      t.integer :free_coupon
      t.string :image
      t.integer :min_purchase
      t.text :description
      t.boolean :up_comming
      t.text :address
      t.text :highlights
      t.text :term_conditions
      t.text :offer
      t.boolean :is_active
      t.references :coupontype
      t.references :merchant_location

      t.timestamps
    end
    add_index :coupons, :coupontype_id
    add_index :coupons, :merchant_location_id
  end
end
