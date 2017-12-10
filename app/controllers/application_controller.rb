class ApplicationController < ActionController::Base

  devise_group :user, contains: [:general_user, :shop_manager]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_actionで下で定義したメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #変数PERMISSIBLE_ATTRIBUTESに新規登録時のリクエストパラメーターにnameとstatusを追加する
  PERMISSIBLE_ATTRIBUTES_SIGNUP = %i(status)
  PERMISSIBLE_ATTRIBUTES_LOGIN = %i(manager_id)

  # Devise helper configuration
  helper_method :current_shop_manager, :current_general_user,
    :require_admin!, :require_restaurant!, :require_staff!

  protected
    #deviseのストロングパラメーターにカラム追加するメソッドを定義
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :occupation, :address, :birthday, :nationality, :sex, :shop_master_id, :branch_office_id, :status, :used_branch_office_id, :multi_store_manager_flag, :employee_status, :register_shop_count, :relation_shops_attributes])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:shop_master_id, :branch_office_id])
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES_SIGNUP)
    end

    private

    # ログイン後のリダイレクト先
  #   def after_sign_in_path_for(resource_or_scope)
   #
  #     #管理者のログイン時のみ以下を検証する
  #     login_branch_office_id  = current_user.branch_office_id
  #      get_branch_office_id_result = CouponShopList.find_by(shop_management_id: login_branch_office_id)
   #
  #      unless get_branch_office_id_result.blank?
  #       #  user = ShopManager.find(current_user.id)
  #        curret_user.status = '30'
  #        #ショップ入力したショップ管理番号にお店の管理者としてクーポンを発行するため、使用中にする
  #        curret_user.used_branch_office_id = current_user.shop_manage_id.branch_office_id
  #        curret_user.save
  #        coupons_path
  #      else
  #        curret_user = ShopManager.find(current_user.id)
  #        curret_user.status = '20'
  #        curret_user.save
  #        root_path
  #      end
  #      #それ以外のパターンは何もしない
  #  end

end
