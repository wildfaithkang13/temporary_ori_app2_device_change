class CouponShopListsController < ApplicationController
  require 'geocoder'
  API_KEY = ENV["GOOGLE_MAP_API"]

  #ショップの管理者のみがリクエストできる(ShopManager)
   before_action :register_post_params, only: [:create, :confirm, :update]
   before_action :authenticate_user!
  def index
    redirect_to root_path
  end

  def new
    @coupon_shop = CouponShopList.new
    #親会社名を取得する
    # getParentCompanyInfo = current_user.shop_master_idをキーに検索する
    @getParentCompanyInfo = AvailableCouponServiceShopMaster.find_by(shop_master_id: current_user.shop_master_id)
  end

  def create
    refisterErrorList = Array.new
    arrayBranchOfficeId = Array.new

    @new_coupon_shop = CouponShopList.new(register_post_params)
    if @new_coupon_shop.all_day_flag
      @new_coupon_shop.open_time = nil
      @new_coupon_shop.close_time = nil
    end

    @new_coupon_shop.shop_master_id = current_user.shop_master_id

    #支店IDを追加する。
    # raise

    #ショップ管理者テーブルを更新する
    @update_shop_manager = ShopManager.find(current_user.id)

    if current_user.branch_office_id.blank?
      #初回登録時でも配列として入れておく
      @new_coupon_shop.branch_office_id = SecureRandom.urlsafe_base64
      # @update_shop_manager.branch_office_id = [@new_coupon_shop.branch_office_id]
      arrayBranchOfficeId.push(@new_coupon_shop.branch_office_id);
      @update_shop_manager.branch_office_id = arrayBranchOfficeId
    else
      #2回目以降の登録の場合
      #[]の状態なのでまず[]を外す
      # @update_shop_manager.branch_office_id = @update_shop_manager.branch_office_id.delete("[")
      # @update_shop_manager.branch_office_id = @update_shop_manager.branch_office_id.delete("]")
      # @update_shop_manager.branch_office_id = @update_shop_manager.branch_office_id.gsub!("\"","")

      @new_coupon_shop.branch_office_id = SecureRandom.urlsafe_base64
      # @update_shop_manager.branch_office_id = [@update_shop_manager.branch_office_id + "," + @new_coupon_shop.branch_office_id]
      # @update_shop_manager.branch_office_id = arrayBranchOfficeId
      @update_shop_manager.branch_office_id.push(@new_coupon_shop.branch_office_id)
    end

    #uuidでidを採番する
    # @new_coupon_shop.branch_office_id = SecureRandom.urlsafe_base64

    #入力した住所を座標に変える
    #参考サイト：https://www.mk-mode.com/octopress/2013/07/02/ruby-google-geocoding-api/

    @BASE_URL = "http://maps.googleapis.com/maps/api/geocode/json"
    url = "#{@BASE_URL}?address=#{URI.encode(@new_coupon_shop.shop_address)}&sensor=false&language=ja"
    res = Net::HTTP.get_response(URI.parse(url))
    status = JSON.parse(res.body)
    if status['status'] == "OK"
      @addr = status['results'][0]['formatted_address']
      @lat  = status['results'][0]['geometry']['location']['lat']
      @lng  = status['results'][0]['geometry']['location']['lng']
    else
      refisterErrorList.push("住所を特定することができませんでした。");
    end
    @new_coupon_shop.shop_latitude = @lat
    @new_coupon_shop.shop_longtitude = @lng

    @new_coupon_shop.shop_latitude = @lat
    @new_coupon_shop.shop_longtitude = @lng

    if refisterErrorList.present?
      flash[:errorlist] = refisterErrorList
      redirect_to action: 'new'
      return;
    end

    if @update_shop_manager.save
    else
      flash[:notice] = "支店ID発行に失敗しました。"
      redirect_to root_path
    end

    if @new_coupon_shop.save
      flash[:notice] = "お客様の支店IDは「" + @new_coupon_shop.branch_office_id + "」です。お忘れにならないようにご注意ください。"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def confirm

    #管理者テーブルを検索しmulti_store_manager_flag、employee_statusの状態を確認する
    @checkDualRegistrationCondition = ShopManager.find(current_user.id)
    #複数店舗登録チェック対象かどうかを判定する。
    if @checkDualRegistrationCondition.employee_status == 20 || (@checkDualRegistrationCondition.employee_status == 10 && !@checkDualRegistrationCondition.multi_store_manager_flag)   then
      #複数店舗登録チェック対象の場合はregister_shop_countをチェックする
      if @checkDualRegistrationCondition.register_shop_count > 1
        refisterErrorList.push("複数店舗登録権限がありません。");
        flash[:errorlist] = refisterErrorList
        redirect_to action: 'new'
        return;
      end
    end

    refisterErrorList = Array.new
    @new_coupon_shop = CouponShopList.new(register_post_params)

    if @new_coupon_shop.telephone_number.blank?
      refisterErrorList.push("電話番号が入力されておりません。");
    end

    if @new_coupon_shop.shop_name.blank?
      refisterErrorList.push("支店名が入力されておりません。");
    end

    if @new_coupon_shop.shop_address.blank?
      refisterErrorList.push("住所が入力されておりません。");
    end

    #空白を消す
    @new_coupon_shop.shop_name.gsub(" ", "")

    #店名に店が入っている場合はエラーとする
    if @new_coupon_shop.shop_name.end_with?("店")
      refisterErrorList.push("店名・支店名の最後に「店」は必要ありません。");
    end

    if @new_coupon_shop.shop_name.include?(@new_coupon_shop.subsidiary_company_name)
      refisterErrorList.push("店名にサービス名が入っています。");
    end

    #電話番号の重複チェック(電話番号の一意性チェック)
    if CouponShopList.where(telephone_number: register_post_params[:telephone_number]).count > 0
      refisterErrorList.push("お客様の入力した電話番号はすでに登録されています。");
      flash[:errorlist] = refisterErrorList
      redirect_to action: 'new'
      return;
    end

    # CouponShopList.where("shop_master_id = :shop_master_id and telephone_number = :telephone_number", shop_master_id: params[:coupon_shop_list][:shop_master_id], telephone_number: params[:coupon_shop_list][:telephone_number])
    # CouponShopList.where("shop_master_id = :shop_master_id and telephone_number = :telephone_number", shop_master_id: params[:coupon_shop_list][:shop_master_id], telephone_number: params[:coupon_shop_list][:telephone_number]).count
    #重複登録を防ぐ。
    if CouponShopList.where("subsidiary_company_name = :subsidiary_company_name and shop_name = :shop_name", subsidiary_company_name: params[:coupon_shop_list][:subsidiary_company_name], shop_name: params[:coupon_shop_list][:shop_name]).count > 0
      refisterErrorList.push("お客様の入力した情報はすでに登録されています。");
      flash[:errorlist] = refisterErrorList
      redirect_to action: 'new'
      return;
    end

    if refisterErrorList.present?
      flash[:errorlist] = refisterErrorList
      redirect_to action: 'new'
      return;
    end

  end

  def edit
    @edit_shop = CouponShopList.find(params[:id])
  end

  def update
    @update_shop = CouponShopList.find_by(branch_office_id: params[:coupon_shop_list][:branch_office_id])

    if @update_shop.update(register_post_params)
      redirect_to root_path, alert: "マイショップを更新しました！"
    else
      render 'edit'
    end
  end

  def show
    ary = Array.new;
    holidays = Array.new
    @shop_detail = CouponShopList.find(params[:id])
    hoge_a = eval(@shop_detail.holiday)
    hoge_a = hoge_a.join(" ")
    hoge_a = hoge_a.split(" ")
    hoge_a.each do |holiday|
      #ここでcase文
      case holiday
        when "Mon" then
          holidays.push("月曜日");
        when "Tue" then
          holidays.push("火曜日");
        when "Wed" then
          holidays.push("水曜日");
        when "Thu" then
          holidays.push("木曜日");
        when "Fri" then
          holidays.push("金曜日");
        when "Sat" then
          holidays.push("土曜日");
        when "Sun" then
          holidays.push("日曜日");
        when "Nat" then
          holidays.push("祝日");
        else
          holidays.push("");
        end
      end
      #念のため曜日を順番通りに並び替えたい。
      hoge_a = holidays
  end

  def destroy
    @delete_shop = CouponShopList.find(params[:id])
    @delete_shop.destroy
    reset_session
    redirect_to new_shop_manager_session_path
  end

  def myshop
    @myshop = CouponShopList.find_by(branch_office_id: current_user[:branch_office_id])
    myShopHolidays = Array.new
    case @myshop.occupation_code
      when 'hotel' then
        @myshop.occupation_code = 'ホテル・旅館'
      when 'gymnasium' then
        @myshop.occupation_code = 'フィットネス関連'
      when 'nightlife' then
        @myshop.occupation_code = '風俗・水商売'
      when 'medical' then
        @myshop.occupation_code = '医療関連'
      when 'retail' then
        @myshop.occupation_code = '小売業'
      when 'fashion' then
        @myshop.occupation_code = 'アパレル・ファッション'
      when 'beauty' then
        @myshop.occupation_code = '美容・コスメ'
      when 'amusement' then
        @myshop.occupation_code = '娯楽・アミューズメント'
    else
        @myshop.occupation_code = 'その他'
    end
    @myshop.holiday = @myshop.holiday.delete("[")
    @myshop.holiday = @myshop.holiday.delete("]")
    @myshop.holiday = @myshop.holiday.gsub!("\"","")
    # "Mon Thu Fri nat"で表示される
    if @myshop.holiday == ""
      @myshop.holiday ="年中無休"
    else
      strAry = @myshop.holiday.split
      strAry.each do |youso|
        case youso
        when "Mon" then
          myShopHolidays.push("月曜日");
        when "Tue" then
          myShopHolidays.push("火曜日");
        when "Wed" then
          myShopHolidays.push("水曜日");
        when "Thu" then
          myShopHolidays.push("木曜日");
        when "Fri" then
          myShopHolidays.push("金曜日");
        when "Sat" then
          myShopHolidays.push("土曜日");
        when "Sun" then
          myShopHolidays.push("日曜日");
        when "Nat" then
          myShopHolidays.push("祝日");
        else
        end
      end
      @myshop.holiday = myShopHolidays
    end
  end

  def issuedcoupon
    @isuuedCoupons = Coupon.where(coupon_shop_lists_id: current_user[:branch_office_id]);
  end

  private
  def coupon_shop_list_params
    params.require(:coupon_shop_list).permit(:telephone_number, :occupation_code, :all_day_flag, :open_time, :close_time, {:holiday => []}, :holiday_condition)
  end

  def register_post_params
    #requireにはテーブル名の単数系が入るので注意すること
    params.require(:coupon_shop_list).permit(:telephone_number, :shop_name, :shop_address, :occupation_code, :all_day_flag,:subsidiary_company_name, :action_name, :open_time, :close_time, {:holiday => []} )
  end
end
