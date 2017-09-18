class AddHolidayToCouponShopLists < ActiveRecord::Migration
  def change
    add_column :coupon_shop_lists, :holiday, :string
  end
end
