class AddRegisterShopCountToShopManagers < ActiveRecord::Migration
  def change
    add_column :shop_managers, :register_shop_count, :integer
  end
end
