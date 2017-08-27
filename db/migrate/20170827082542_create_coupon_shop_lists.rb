class CreateCouponShopLists < ActiveRecord::Migration
  def change
    create_table :coupon_shop_lists do |t|
      t.string :telephone_number
      t.string :shop_name
      t.string :shop_address
      t.float :shop_latitude
      t.float :shop_longtitude
      t.boolean :all_day_flag
      t.datetime :open_time
      t.datetime :close_time
      t.timestamps null: false
    end
  end
end
