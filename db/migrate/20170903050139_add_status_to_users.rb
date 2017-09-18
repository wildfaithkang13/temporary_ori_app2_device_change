class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, limit: 2
  end
end
