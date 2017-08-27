class AddShopAddressToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :shop_address, :string
  end
end
