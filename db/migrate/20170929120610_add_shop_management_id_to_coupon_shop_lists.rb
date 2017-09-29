class AddShopManagementIdToCouponShopLists < ActiveRecord::Migration
  def change
    add_column :coupon_shop_lists, :shop_management_id, :string
    add_column :coupon_shop_lists, :occupation_code, :string
  end
end
