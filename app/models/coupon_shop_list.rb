class CouponShopList < ActiveRecord::Base
  self.primary_key = :shop_master_id

  validates :telephone_number, :shop_name, :shop_address, presence: true
  has_many :coupons, dependent: :destroy
end
