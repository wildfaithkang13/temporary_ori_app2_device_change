class ShopManager < User
  #ログイン時のリクエストパラメータに以下を追加する
  attr_accessor :manager_id, :shop_manage_id

  validates :email, :password, :manager_id, presence: true, on: :sign_in_params #管理者ID必須チェック
end
