class AddBarcodeValueColumnToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :coupon_one_barcode_value, :string
  end
end
