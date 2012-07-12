class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :email
      t.string :url
      t.string :image

      t.timestamps
    end
  end
end
