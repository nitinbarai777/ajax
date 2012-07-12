class CreateCoupontypes < ActiveRecord::Migration
  def change
    create_table :coupontypes do |t|
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
