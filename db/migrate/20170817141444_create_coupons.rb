class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :shop_name
      t.text :coupon_content
      t.timestamps null: false
    end
  end
end
