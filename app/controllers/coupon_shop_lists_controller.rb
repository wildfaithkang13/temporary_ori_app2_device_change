class CouponShopListsController < ApplicationController
  #ショップの管理者のみがリクエストできる(ShopManager)
   before_action :register_post_params, only: [:create, :confirm]
  def index
    redirect_to root_path
  end

  def new
    @new_coupon_shop = CouponShopList.new
  end

  def create
    @new_coupon_shop = CouponShopList.new(register_post_params)
    if @new_coupon_shop.all_day_flag
      @new_coupon_shop.open_time = nil
      @new_coupon_shop.close_time = nil
    end
    @new_coupon_shop.shop_management_id = SecureRandom.uuid
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
      render 'new'
      #redirect_to root_path, notice: "住所取得処理に失敗しました。"
    end

    @new_coupon_shop.shop_latitude = @lat
    @new_coupon_shop.shop_longtitude = @lng

    if @new_coupon_shop.save
      redirect_to root_path, notice: "利用登録完了！"
    else
      render 'new'
    end
  end

  def confirm
    @new_coupon_shop = CouponShopList.new(register_post_params)
    #raise
    #@new_coupon_shop.holiday = params[:coupon_shop_list][:holiday]
  end

  def show
    @shop_detail = CouponShopList.find(params[:id])
  end

  def myshop
    @myshop = CouponShopList.find_by(shop_management_id: current_user.used_shop_manage_id)
  end

  private
  def register_post_params
    #requireにはテーブル名の単数系が入るので注意すること
    params.require(:coupon_shop_list).permit(:telephone_number, :shop_name, :shop_address, :occupation_code, :all_day_flag, :open_time, :close_time, {:holiday => []} )
  end
end
