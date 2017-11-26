class ShopManager < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #変数を参照、代入するためのもの
  # attr_accessor :action_name

  # belong_to　親テーブルに検索する時に行うので
  belongs_to :available_coupon_service_shop_master, primary_key: :shop_master_id, foreign_key: :shop_master_id

  # validates :email, :password, :shop_master_code, presence: true, on: :sign_in_params #管理者ID必須チェック
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
