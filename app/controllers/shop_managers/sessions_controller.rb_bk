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
   getRelationShop = RelationShop.find_by(shop_master_id: params[:shop_manager][:shop_master_id])
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
     errorList.push("店舗マスタIDが入力されておりません");
   else
     #入力した店舗マスタIDをキーにサービス利用可能店舗マスタ(available_coupon_service_shop_masters)テーブルを検索する
     # get_shop_master_id_result = AvailableCouponServiceShopMaster.find_by(shop_master_id: login_shop_master_id)

     if getRelationShop.blank?
       errorList.push("該当する店舗マスタIDが見つかりません");
     # elsif get_shop_master_id_result.shop_master_id != current_user.shop_master_id
   # elsif get_shop_master_id_result.shop_master_id !=
   #      errorList.push("店舗マスタIDの照合に失敗しました。");
     end

   end

    isError = !errorList.blank?
    if isError
        reset_session
        flash[:errorlist] = errorList
        redirect_to action: 'new'
        return;
    end

    super
  end

  def after_sign_in_path_for(resource_or_scope)

      #管理者のログイン時のみ以下を検証する
      login_branch_office_id  = params[:shop_manager][:branch_office_id]
       get_branch_office_id_result = CouponShopList.find_by(branch_office_id: login_branch_office_id)

       #入力した支店IDをチェックする。ユーザーが利用できる支店IDかどうかをチェエックする
       # params[:shop_manager][:email]で管理者テーブルを検索
       get_shop_manager_info = ShopManager.find_by(email: params[:shop_manager][:email]);
       get_own_branch_office_id = get_shop_manager_info[:branch_office_id]

       # @myshop.holiday = @myshop.holiday.delete("[")
       # @myshop.holiday = @myshop.holiday.delete("]")
       # @myshop.holiday = @myshop.holiday.gsub!("\"","")
       # s.include?(0x6c)

# get_shop_manager_info[:branch_office_id].split(",")

       # raise

       # login_branch_office_id


       unless get_branch_office_id_result.blank?
        #  user = ShopManager.find(current_user.id)
         current_user.shop_master_id = params[:shop_manager][:shop_master_id]
         current_user.status = '30'
         #ショップ入力したショップ管理番号にお店の管理者としてクーポンを発行するため、使用中にする
         #current_user.branch_office_id = get_branch_office_id_result.branch_office_id
         current_user.save
         coupons_path
       else
         curret_user = ShopManager.find(current_user.id)
         current_user.shop_master_id = params[:shop_manager][:shop_master_id]
         curret_user.status = '20'
         curret_user.save
         # root_path
         coupons_path
       end
       #それ以外のパターンは何もしない
   end


end
