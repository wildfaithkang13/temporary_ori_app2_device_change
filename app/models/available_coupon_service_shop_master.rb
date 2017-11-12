class AvailableCouponServiceShopMaster < ActiveRecord::Base

  #主キーをidからshop_master_idに変更。管理者テーブルに対して外部キーの設定を行う(キー名は同じ)
  has_many :shop_managers, primary_key: :shop_master_id, foreign_key: :shop_master_id, dependent: :delete_all
end
