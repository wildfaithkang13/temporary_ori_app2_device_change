class ApplicationController < ActionController::Base

  devise_group :user, contains: [:general_user, :shop_manager]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_actionで下で定義したメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #変数PERMISSIBLE_ATTRIBUTESに新規登録時のリクエストパラメーターにnameとstatusを追加する
  #PERMISSIBLE_ATTRIBUTES = %i(status)
  PERMISSIBLE_ATTRIBUTES = %i(status)
  PERMISSIBLE_ATTRIBUTES_LOGIN = %i(manager_id)

  # Devise helper configuration
  helper_method :current_shop_manager, :current_general_user,
    :require_admin!, :require_restaurant!, :require_staff!

  protected
    #deviseのストロングパラメーターにカラム追加するメソッドを定義
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:sign_in, keys: PERMISSIBLE_ATTRIBUTES_LOGIN)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
    end

end
