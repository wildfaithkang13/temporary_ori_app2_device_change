module CouponShopListsHelper

  def coupon_shop_info_check
    if action_name == 'new' || action_name == 'confirm'
       confirm_coupon_shop_lists_path
    elsif action_name == 'edit'
      confirm_coupon_shop_lists_path
    end
  end
end
