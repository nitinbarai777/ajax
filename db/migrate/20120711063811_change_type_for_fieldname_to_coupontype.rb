class ChangeTypeForFieldnameToCoupontype < ActiveRecord::Migration
  def self.up
    change_table :coupontypes do |t|
      t.change :is_active, :boolean, :default => true
    end
  end
end
