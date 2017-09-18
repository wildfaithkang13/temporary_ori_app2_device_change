class CouponsController < ApplicationController
  before_action :authenticate_user!
  def index
    @gmapkey = ENV["GOOGLE_MAP_API"]
    @coupons = Coupon.all

    @nearby_shop = CouponShopList.all
    @googlemaps = @nearby_shop.map{|shop| {id: shop.id, shop_management_id: shop.shop_management_id ,shop_name: shop.shop_name, shop_latitude: shop.shop_latitude, shop_longtitude: shop.shop_longtitude }}.to_json
  end

  def new
    @target_shop_manage_id = current_user.used_shop_manage_id
    @myshop = CouponShopList.find_by(shop_management_id: @target_shop_manage_id)
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupons_params)
    @coupon.available_end_time = @coupon.available_end_time + 3599
    @coupon.coupon_shop_lists_id = current_user.used_shop_manage_id
    if @coupon.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to root_path, notice: "クーポンを投稿しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def edit
  end

  def show
    @coupon_detail = Coupon.find(params[:id])
  end

  #クーポンを取得するための独自アクションを設定
  def getcoupons
    get_coupons = Array.new
    sample = JSON.parse(params[:target_shop_list])

    sample.each_with_index.reverse_each do |shop_management_id, index|
    #店舗管理IDをキーにクーポンを取得する
    tmps = Coupon.where(coupon_shop_lists_id: sample[index]['shop_management_id'])
      tmps.each do |tmp|
        get_coupons.push(tmp)
      end
    end
    @get_coupon_results = get_coupons
    respond_to do |format|
     # JS形式でレスポンスを返します。
     format.js { render :index }
    end
  end


  def confirm
    @coupon = Coupon.new(coupons_params)
  end

  private
  def coupons_params
    params.require(:coupon).permit(:shop_name, :shop_address, :coupon_content, :available_start_time, :available_end_time)
  end
end
