class GeneralUsers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create

    #エラーメッセージを配列として格納する
    errorList = Array.new

    #ログイン画面で入力した管理者IDをアトリビュートに入れる
    login_email = params[:general_user][:email]
    login_password = params[:general_user][:password]

    if login_email.blank?
      errorList.push("メールアドレスが入力されておりません。");
    end

    if login_password.blank?
      errorList.push("パスワードが入力されておりません。");
    end

    isError = !errorList.blank?
    if isError
        flash[:errorlist] = errorList
        redirect_to action: 'new'
        return;
    end

    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
