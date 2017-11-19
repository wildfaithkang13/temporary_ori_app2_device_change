class GeneralUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #ログイン時のリクエストパラメータに以下を追加する
  #attr_accessor :manager_id, :shop_manage_id
attr_accessor :agreement

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
