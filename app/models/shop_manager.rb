class ShopManager < User
  #ログイン時のリクエストパラメータに以下を追加する
  attr_accessor :manager_id, :shop_manage_id

  validates :manager_id, presence: true #管理者ID
  validates :shop_manage_id, presence: true #ショップ管理ID

  validate :check_test

  def check_test
    binding.pry
  end
end
