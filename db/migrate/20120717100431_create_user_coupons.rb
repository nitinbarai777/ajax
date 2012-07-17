class CreateUserCoupons < ActiveRecord::Migration
  def change
    create_table :user_coupons do |t|
      t.string :message
      t.string :message_id
      t.string :message_status
      t.string :error_text
      t.references :user
      t.references :coupon

      t.timestamps
    end
    add_index :user_coupons, :user_id
    add_index :user_coupons, :coupon_id
  end
end
