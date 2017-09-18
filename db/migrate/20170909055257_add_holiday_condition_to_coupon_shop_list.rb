class AddHolidayConditionToCouponShopList < ActiveRecord::Migration
  def change
    add_column :coupon_shop_lists, :holiday_condition, :boolean
  end
end
