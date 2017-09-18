class AddUsedShopManageIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :used_shop_manage_id, :string
  end
end
