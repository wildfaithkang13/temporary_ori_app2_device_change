class AddLocateToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :latitude, :float
    add_column :coupons, :longitude, :float
  end
end
