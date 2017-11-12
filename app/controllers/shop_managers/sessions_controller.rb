class ShopManagers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   binding.pry
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # POST /resource/sign_in
 def create
   #エラーメッセージを配列として格納する
   errorList = Array.new

   #ログイン画面で入力した管理者IDをアトリビュートに入れる
   login_email = params[:shop_manager][:email]
   password = params[:shop_manager][:password]
   login_shop_master_id = params[:shop_manager][:shop_master_id]
   login_branch_office_id  = params[:shop_manager][:branch_office_id]

   if login_email.blank?
     errorList.push("メールアドレスが入力されておりません。");
   end

   if password.blank?
     errorList.push("パスワードが入力されておりません。");
   end

   if login_shop_master_id.blank?
    #  reset_session
     errorList.push("店舗マスタIDが入力されておりません");
     flash[:errorlist] = errorList
     redirect_to action: 'new'
     return;
    end

    #入力した店舗マスタIDをキーにサービス利用可能店舗マスタ(available_coupon_service_shop_masters)テーブルを検索する
    get_shop_master_id_result = AvailableCouponServiceShopMaster.find_by(shop_master_id: login_shop_master_id)

    if get_shop_master_id_result.blank?
      # reset_session
      # redirect_to new_shop_manager_session_path, alert: "入力した店舗マスタIDが存在しません。"
      # return;
      errorList.push("入力されておりません");
      flash[:errorlist] = errorList
      redirect_to action: 'new'
      return;
    end

      #  get_branch_office_id_result = CouponShopList.find_by(shop_management_id: login_branch_office_id)
      #  unless get_branch_office_id_result.blank?
      #   #  user = ShopManager.find(current_user.id)
      #    user.status = '30'
      #    #ショップ入力したショップ管理番号にお店の管理者としてクーポンを発行するため、使用中にする
      #    user.used_branch_office_id = current_user.shop_manage_id.branch_office_id
      #    user.save
      #  else
      #    user = ShopManager.find(current_user.id)
      #    user.status = '20'
      #    user.save
      #  end

      # binding.pry

       super

   #会員登録していないユーザーのログインまたはログイン情報が見つからない場合
  #  if current_user.blank?
  #    flash[:errorlist] = errorList
  #    redirect_to action: 'new'
  #    return;
  #  else
   #
  #    #入力したショップ管理をキーにクーポンショップリストテーブルを検索する
  #    get_branch_office_id_result = CouponShopList.find_by(shop_management_id: login_branch_office_id)
  #    unless get_branch_office_id_result.blank?
  #      user = ShopManager.find(current_user.id)
  #      user.status = '30'
  #      #ショップ入力したショップ管理番号にお店の管理者としてクーポンを発行するため、使用中にする
  #      user.used_branch_office_id = current_user.shop_manage_id.branch_office_id
  #      user.save
  #    else
  #      user = ShopManager.find(current_user.id)
  #      user.status = '20'
  #      user.save
  #    end
  #    super
  #  end
  end
end
