class AddValidDateToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :valid_from, :date
    add_column :coupons, :valid_to, :date
  end
end
