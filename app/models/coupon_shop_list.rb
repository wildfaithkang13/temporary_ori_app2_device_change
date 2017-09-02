class CouponShopList < ActiveRecord::Base
  validates :telephone_number, :shop_name, :shop_address, presence: true
  #geocoded_by :shop_address
  #after_validation :geocode, if: :shop_address_changed?
end
