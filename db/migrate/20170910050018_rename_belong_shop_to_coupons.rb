class RenameBelongShopToCoupons < ActiveRecord::Migration
  def change
    rename_column :coupons, :belong_shop, :coupon_shop_lists_id
  end
end
