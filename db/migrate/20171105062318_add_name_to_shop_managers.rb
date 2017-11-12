class AddNameToShopManagers < ActiveRecord::Migration
  def change
    add_column :shop_managers, :name, :string
  end
end
