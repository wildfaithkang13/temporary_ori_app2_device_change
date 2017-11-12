class AddColumnsToGenerateUsers < ActiveRecord::Migration
  def change
    add_column :general_users, :occupation, :string
    add_column :general_users, :address, :string
    add_column :general_users, :birthday, :string
    add_column :general_users, :nationality, :string
    add_column :general_users, :sex, :string #smaillint型として扱う
  end
end
