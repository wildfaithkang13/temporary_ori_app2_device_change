class RemoveShopMasterIdFromShopManagers < ActiveRecord::Migration
  def change
    remove_column :shop_managers, :shop_master_id, :string
  end
end
