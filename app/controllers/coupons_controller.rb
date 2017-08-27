class CouponsController < ApplicationController
  before_action :authenticate_user!
  def index
    #トップページが表示された時はデフォルトとして現在地を表示させる
    #@latitude = '35.6585805'
    #@longitude = '139.7454329'
    #@address = '〒105-0011 東京都港区芝公園４丁目２-８'
    #Google MapのAPIキーを取得する
    @gmapkey = ENV["GOOGLE_MAP_API"]
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
  end

  def create
    # = SecureRandom.uuid
    @coupon = Coupon.new(coupons_params)
    @coupon.available_end_time = @coupon.available_end_time + 3599
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

  def confirm
    @coupon = Coupon.new(coupons_params)
    #render :index if @coupon.invalid?
  end

  #クーポン投稿利用登録画面へ遷移する
  def register_post

  end

  private
  def coupons_params
    params.require(:coupon).permit(:shop_name, :shop_address, :coupon_content, :available_start_time, :available_end_time)
  end
end
