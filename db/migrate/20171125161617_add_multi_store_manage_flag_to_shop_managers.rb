class AddMultiStoreManageFlagToShopManagers < ActiveRecord::Migration
  def change
    add_column :shop_managers, :multi_store_manager_flag, :boolean
  end
end
