class ShopManagers::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  def new
    @shop_manager = ShopManager.new
    @shop_manager.relation_shops.build
    # super
  end

  def create
      #デフォルトはコメントアウトしておく

      array_shop_master_id = params[:shop_manager][:relation_shops_attributes]

      target_shop_master = array_shop_master_id.values.map{|value| value["shop_master_id"]}

      available = AvailableCouponServiceShopMaster.where(shop_master_id: target_shop_master)

      #メルアドとパスワード未入力は親クラスで検知できるが、コントローラ側で即判定を行う。
      errorList = Array.new

      #リクエストで送られたショップマスタIDを元にレコードを作成する
      shop_master_id = params[:shop_manager][:relation_shops_attributes]
      @create = ShopManager.new(set_associate_params)

      #ここで管理者テーブルを設定してはいけない
      #<https://qiita.com/xend/items/79184ded56158ea1b97a> にあるBULK INSERTを使えば一括で登録できそう。

      register_name = params[:shop_manager][:name]
      array_shop_master_id = params[:shop_manager][:relation_shops_attributes]
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

      if @create.valid?
      else
        errorList.push("登録に失敗しました。");
      end

      # build_resource(@create)

      isError = !errorList.blank?
      if isError
          flash[:errorlist] = errorList
          redirect_to action: 'new'
          return;
      end

       #継承元のdeviseのコントローラーの動きは<https://github.com/plataformatec/devise>を確認すること

       @create.save
      yield @create if block_given?
      if @create.persisted?
        if @create.active_for_authentication?
          # binding.pry
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, @create)
          respond_with @create, location: after_sign_up_path_for(@create)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with @create, location: after_inactive_sign_up_path_for(@create)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with @create
      end
    end



  # def build_resource(hash=nil)
  #   hash[:shop_master_id] = params[:shop_manager][:shop_master_id]
  #   super
  # end

  # GET /resource/edit
  def edit
    @edit = RelationShop.where(shop_manager_id: current_user.id)
    super
  end

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
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

private
  def set_associate_params
    #params.require(:relation_shop).permit(:name, :shop_master_id)
    params.require(:shop_manager).permit(:name,:status, :email, :occupation, :employee_status, :register_shop_count, :multi_store_manager_flag, :address, :password, :password_confirmation, :birthday, :nationality, :sex,
       relation_shops_attributes: [:id, :name, :shop_master_id, :not_used, :_destroy])
  end

end
