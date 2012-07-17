class AddBirthDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_date, :date
    add_column :users, :anniversary_date, :date
  end
end
