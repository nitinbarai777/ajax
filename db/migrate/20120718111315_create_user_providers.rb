class CreateUserProviders < ActiveRecord::Migration
  def change
    create_table :user_providers do |t|
      t.string :username
      t.string :email
      t.string :mobile_number

      t.timestamps
    end
  end
end
