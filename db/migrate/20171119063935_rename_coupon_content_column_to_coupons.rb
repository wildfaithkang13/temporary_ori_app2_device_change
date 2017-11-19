class RenameCouponContentColumnToCoupons < ActiveRecord::Migration
  def change
    rename_column :coupons, :coupon_content, :coupon_title
    add_column :coupons, :coupon_content, :string
  end
end
