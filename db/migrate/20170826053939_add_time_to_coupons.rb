class AddTimeToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :available_start_time, :timestamp
    add_column :coupons, :available_end_time, :timestamp
  end
end
