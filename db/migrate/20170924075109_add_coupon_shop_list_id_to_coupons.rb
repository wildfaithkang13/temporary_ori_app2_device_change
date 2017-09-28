class AddCouponShopListIdToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :coupon_shop_list_id, :integer
  end
end
