class AddIncomeToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :income, :string
  end
end
