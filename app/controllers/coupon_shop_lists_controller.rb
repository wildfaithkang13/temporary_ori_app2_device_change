class CouponShopListsController < ApplicationController

  #ショップの管理者のみがリクエストできる(ShopManager)
  def index
  end

  def new
    @new_coupon_shop = CouponShopList.new
  end

  def create
    @new_coupon_shop = CouponShopList.new(register_post_params)
    if @new_coupon_shop.all_day_flag
      @new_coupon_shop.open_time = nil
      @new_coupon_shop.close_time = nil
      @new_coupon_shop.shop_management_id = SecureRandom.uuid
    end

    if @new_coupon_shop.save
      redirect_to coupon_shop_lists_path, notice: "利用登録完了！"
    else
      render 'new'
    end
  end

  def confirm
    @new_coupon_shop = CouponShopList.new(register_post_params)
  end

  private
  def register_post_params
    #requireにはテーブル名の単数系が入るので注意すること
    params.require(:coupon_shop_list).permit(:telephone_number, :shop_name, :shop_address, :all_day_flag, :open_time, :close_time)
  end
end
