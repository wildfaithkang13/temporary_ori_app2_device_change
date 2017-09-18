class ShopManagers::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     #アトリビュート名を設定すること
     #self => validを呼び出したユーザを意味する
     #テーブルに縛られないモデルを作成することができる

     #ログイン画面で入力した管理者IDをアトリビュートに入れる
     current_user.manager_id = params[:shop_manager][:manager_id]
     if current_user.manager_id.blank?
       reset_session
       redirect_to new_shop_manager_session_path, alert: "管理者IDが入力されておりません。"
     elsif current_user.manager_id != "test"
       reset_session
       redirect_to new_shop_manager_session_path, alert: "管理者IDが間違っています。"
     else
       #入力したショップ管理をキーにクーポンショップリストテーブルを検索する
       current_user.shop_manage_id = CouponShopList.find_by_shop_management_id(params[:shop_manager][:shop_manage_id])
       unless current_user.shop_manage_id.blank?
         user = ShopManager.find(current_user.id)
         user.status = '30'
         #ショップ入力したショップ管理番号にお店の管理者としてクーポンを発行するため、使用中にする
         user.used_shop_manage_id = current_user.shop_manage_id.shop_management_id
         user.save
       else
         user = ShopManager.find(current_user.id)
         user.status = '20'
         user.save
       end
       super
     end
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
   #def configure_sign_in_params
     #devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
   #end

  #ログアウト時に指定のページに遷移させるための設定
  #参考サイト：http://qiita.com/yang1005/items/8820e381233868e75bef
  #SessionsControllerをカスタマイズした場合は、カスタマイズしたコントローラ中に追加します
  def after_sign_out_path_for(resource)
    new_session_path(resource_name)
  end

  #ログイン成功後に遷移するページやページ遷移前の処理を記述できる
  def after_sign_in_path_for(resource)
    root_path
  end

end
