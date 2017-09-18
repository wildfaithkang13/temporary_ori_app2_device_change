class AddBelongShopToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :belong_shop, :string
  end
end
