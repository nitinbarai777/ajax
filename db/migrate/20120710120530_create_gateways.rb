class CreateGateways < ActiveRecord::Migration
  def change
    create_table :gateways do |t|
      t.string :name
      t.boolean :is_active, :default => true

      t.timestamps
    end
  end
end
