class ShopManager < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #変数を参照、代入するためのもの
  # attr_accessor :action_name
  # accepts_nested_attributes_for :shop_manager_shop_associations, allow_destroy: true

  # belong_to　親テーブルに検索する時に行うので
  belongs_to :available_coupon_service_shop_master, primary_key: :shop_master_id, foreign_key: :shop_master_id
  #accepts_nested_attributes_forはhas_manyの下に記載しないと起動に失敗する。
  has_many :relation_shops, dependent: :destroy, inverse_of: :shop_manager
  accepts_nested_attributes_for :relation_shops

  # validates :email, :password, :shop_master_code, presence: true, on: :sign_in_params #管理者ID必須チェック
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
