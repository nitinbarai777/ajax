class AddProviderToUserCoupon < ActiveRecord::Migration
  def change
    add_column :user_coupons, :provider, :string
  end
end
