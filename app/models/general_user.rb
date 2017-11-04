class GeneralUser < User
  # 利用規約への同意フラグ（カラムなし）
  #validates_acceptance_of :agree1, allow_nil: false, message: "※会員登録には利用規約への同意が必要です。", on: :create
  #validates :terms_of_service, acceptance: true

  attr_accessor :agreement

  validates_acceptance_of :agreement, allow_nil: false, message: "※会員登録には利用規約への同意が必要です。", on: :create
end
