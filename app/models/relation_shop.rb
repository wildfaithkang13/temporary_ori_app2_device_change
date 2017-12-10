class RelationShop < ActiveRecord::Base
  belongs_to :shop_manager
  belongs_to :shop_master
end
