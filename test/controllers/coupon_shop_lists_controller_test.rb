require 'test_helper'

class CouponShopListsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
