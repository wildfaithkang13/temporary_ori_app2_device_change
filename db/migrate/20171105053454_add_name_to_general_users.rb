class AddNameToGeneralUsers < ActiveRecord::Migration
  def change
    add_column :general_users, :name, :string
  end
end
