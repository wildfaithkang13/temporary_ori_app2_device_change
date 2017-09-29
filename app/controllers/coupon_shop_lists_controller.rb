class CouponShopListsController < ApplicationController
  #ショップの管理者のみがリクエストできる(ShopManager)
   before_action :register_post_params, only: [:create, :confirm]
   before_action :authenticate_user!
  def index
    redirect_to root_path
  end

  def new
    @new_coupon_shop = CouponShopList.new
  end

  def create
    refisterErrorList = Array.new
    @new_coupon_shop = CouponShopList.new(register_post_params)
    if @new_coupon_shop.all_day_flag
      @new_coupon_shop.open_time = nil
      @new_coupon_shop.close_time = nil
    end


    @new_coupon_shop.shop_management_id = SecureRandom.uuid

    if @new_coupon_shop.telephone_number.blank?
      refisterErrorList.push("電話番号が入力されておりません。");
    end

    if @new_coupon_shop.shop_name?
      # refisterErrorList.push("店名が入力されておりません。");
    end

    if @new_coupon_shop.shop_address.blank?
      refisterErrorList.push("住所が入力されておりません。");
    end

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

    if refisterErrorList.present?
      flash[:errorlist] = refisterErrorList
      redirect_to action: 'new'
      return;
    end

    if @new_coupon_shop.save
      # redirect_to root_path, error: @new_coupon_shop.shop_management_id
      flash[:notice] = "お客様のショップ管理IDは「" + @new_coupon_shop.shop_management_id + "」です。お忘れにならないようにご注意ください。"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def confirm
    @new_coupon_shop = CouponShopList.new(register_post_params)
  end

  def edit
    @edit_shop = CouponShopList.find(params[:id])
  end

  def update
    @update_shop = CouponShopList.find(params[:id])
    if @update_shop.update(coupon_shop_list_params)
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
    @myshop = CouponShopList.find_by(shop_management_id: current_user.used_shop_manage_id)
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
    @isuuedCoupons = Coupon.where(coupon_shop_lists_id: current_user.used_shop_manage_id);
  end

  private
  def coupon_shop_list_params
    params.require(:coupon_shop_list).permit(:telephone_number, :occupation_code, :all_day_flag, :open_time, :close_time, {:holiday => []}, :holiday_condition)
  end

  def register_post_params
    #requireにはテーブル名の単数系が入るので注意すること
    params.require(:coupon_shop_list).permit(:telephone_number, :shop_name, :shop_address, :occupation_code, :all_day_flag, :open_time, :close_time, {:holiday => []} )
  end
end
