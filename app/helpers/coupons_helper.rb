module CouponsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_coupons_path
    elsif action_name == 'edit'
      coupon_path
    end
  end
end
