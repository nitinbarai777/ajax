require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { address: @coupon.address, description: @coupon.description, free_coupon: @coupon.free_coupon, highlights: @coupon.highlights, image: @coupon.image, is_active: @coupon.is_active, min_purchase: @coupon.min_purchase, name: @coupon.name, offer: @coupon.offer, price: @coupon.price, term_conditions: @coupon.term_conditions, up_comming: @coupon.up_comming }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    put :update, id: @coupon, coupon: { address: @coupon.address, description: @coupon.description, free_coupon: @coupon.free_coupon, highlights: @coupon.highlights, image: @coupon.image, is_active: @coupon.is_active, min_purchase: @coupon.min_purchase, name: @coupon.name, offer: @coupon.offer, price: @coupon.price, term_conditions: @coupon.term_conditions, up_comming: @coupon.up_comming }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to coupons_path
  end
end
