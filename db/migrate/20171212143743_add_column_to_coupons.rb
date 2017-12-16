class AddColumnToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :coupon_type, :integer
    add_column :coupons, :available_limit_count, :integer
  end
end
