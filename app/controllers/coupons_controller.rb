class CouponsController < ApplicationController
  #サイトの説明のみはログインなしで参照できる
  before_action :authenticate_user!, except: [:explanation_coupons]
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
    @targetSendEmail = current_user.email
    @coupon = Coupon.new(coupons_params)
    @associated = CouponShopList.find_by(shop_management_id: current_user.used_shop_manage_id)
    @coupon.available_end_time = @coupon.available_end_time + 3599
    @coupon.coupon_shop_lists_id = current_user.used_shop_manage_id
    @coupon.coupon_shop_list_id = @associated.id
    if @coupon.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to root_path, alert: "クーポンを投稿しました！"

      #TODO クーポン発行元の半径3km以内にいるユーザに対してメールを配信したい。
      NoticeMailer.sendmail_coupon(@coupon, @targetSendEmail).deliver
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def show
    @coupon_detail = Coupon.find(params[:id])
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy
    redirect_to root_path, notice: "クーポンを削除しました！"
  end

  def update
    refisterErrorList = Array.new
    if params[:coupon][:coupon_content].blank?
      refisterErrorList.push("クーポン内容が入力されておりません。");
    end

    if params[:coupon][:available_start_time].blank?
      refisterErrorList.push("クーポン利用開始時刻が設定されておりません。");
    end

    if params[:coupon][:available_end_time].blank?
      refisterErrorList.push("クーポン利用終了時刻が設定されておりません。");
    end

    if refisterErrorList.present?
      flash[:errorlist] = refisterErrorList
      redirect_to action: 'edit'
      return;
    end

    @updateCoupon = Coupon.find(params[:id])
    if @updateCoupon.update(coupons_params)
      redirect_to root_path, notice: "クーポンを更新しました！"
    else
      render 'edit'
    end
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
    confirmErrorList = Array.new
    @coupon = Coupon.new(coupons_params)
    if @coupon.coupon_content.blank?
      confirmErrorList.push('クーポン内容が未入力です。');
    end

    if @coupon.available_start_time.blank?
      confirmErrorList.push('クーポン利用開始時刻が未入力です。');
    end

    if @coupon.available_end_time.blank?
      confirmErrorList.push('クーポン利用終了時刻が未入力です。');
    end

    if confirmErrorList.present?
      flash[:errorlist] = confirmErrorList
      redirect_to action: 'new'
      return;
    end
  end

  private
  def coupons_params
    params.require(:coupon).permit(:shop_name, :shop_address, :coupon_content, :available_start_time, :available_end_time)
  end
end
