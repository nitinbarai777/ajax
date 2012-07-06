class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :contact
      t.integer :is_admin
      t.timestamps
    end
  end
end
