class CouponShopList < ActiveRecord::Base
  validates :telephone_number, :shop_name, :shop_address, presence: true
end
