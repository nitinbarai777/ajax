require 'test_helper'

class UserCouponsControllerTest < ActionController::TestCase
  setup do
    @user_coupon = user_coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_coupon" do
    assert_difference('UserCoupon.count') do
      post :create, user_coupon: { error_text: @user_coupon.error_text, message: @user_coupon.message, message_id: @user_coupon.message_id, message_status: @user_coupon.message_status }
    end

    assert_redirected_to user_coupon_path(assigns(:user_coupon))
  end

  test "should show user_coupon" do
    get :show, id: @user_coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_coupon
    assert_response :success
  end

  test "should update user_coupon" do
    put :update, id: @user_coupon, user_coupon: { error_text: @user_coupon.error_text, message: @user_coupon.message, message_id: @user_coupon.message_id, message_status: @user_coupon.message_status }
    assert_redirected_to user_coupon_path(assigns(:user_coupon))
  end

  test "should destroy user_coupon" do
    assert_difference('UserCoupon.count', -1) do
      delete :destroy, id: @user_coupon
    end

    assert_redirected_to user_coupons_path
  end
end
