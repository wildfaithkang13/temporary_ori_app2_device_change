class ShopManagers::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    #デフォルトはコメントアウトしておく
    available = AvailableCouponServiceShopMaster.find_by(shop_master_id: params[:shop_manager][:shop_master_id])

    #メルアドとパスワード未入力は親クラスで検知できるが、コントローラ側で即判定を行う。
    errorList = Array.new

    register_name = params[:shop_manager][:name]
    register_email = params[:shop_manager][:email]
    register_occupation = params[:shop_manager][:occupation]
    register_address = params[:shop_manager][:address]
    register_password = params[:shop_manager][:password]
    register_birthday = params[:shop_manager][:birthday]
    register_nationality = params[:shop_manager][:nationality]
    register_sex = params[:shop_manager][:sex]
    agreementValue = params[:shop_manager][:agreement]

    if register_name.blank?
      errorList.push("名前が入力されておりません");
    end

    if register_email.blank?
      errorList.push("メールアドレスが入力されておりません");
    end

    if register_email.blank?
      errorList.push("職業が選択されておりません");
    end

    if register_address.blank?
      errorList.push("住所が入力されておりません");
    end

    if available.blank?
      errorList.push("店舗マスタIDが存在しません");
    end

    if register_password.blank?
      errorList.push("パスワードが入力されておりません。");
    end

    if register_birthday.blank?
      errorList.push("生年月日が設定されておりません");
    end

    if register_nationality.blank?
      errorList.push("国籍が設定されておりません");
    end

    #以下のエラーが通常ありえないので万が一発生した場合は危険ユーザー(ハッカー)として扱う。
    if register_sex.blank?
      errorList.push("性別が設定されておりません");
    end

    if agreementValue == "0"
      errorList.push("利用規約同意のチェックがついていません");
    end

    isError = !errorList.blank?
    if isError
        flash[:errorlist] = errorList
        redirect_to action: 'new'
        return;
    end

     #継承元のdeviseのコントローラーの動きはhttps://github.com/plataformatec/deviseを確認すること
     super
  end

  # def build_resource(hash=nil)
  #   hash[:shop_master_id] = params[:shop_manager][:shop_master_id]
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
