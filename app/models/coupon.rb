class Coupon < ActiveRecord::Base
  #validates :shop_name, :shop_address, :coupon_content, :available_start_time, :available_end_time, presence: true
  validates :shop_name, presence: true
  validates :shop_address, presence: true
  validates :coupon_content, presence: true
  validates :available_start_time, presence: true
  validates :available_end_time, presence: true
  belongs_to :coupon_shop_list
end
