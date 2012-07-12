require 'test_helper'

class CoupontypesControllerTest < ActionController::TestCase
  setup do
    @coupontype = coupontypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupontypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupontype" do
    assert_difference('Coupontype.count') do
      post :create, coupontype: { is_active: @coupontype.is_active, name: @coupontype.name }
    end

    assert_redirected_to coupontype_path(assigns(:coupontype))
  end

  test "should show coupontype" do
    get :show, id: @coupontype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupontype
    assert_response :success
  end

  test "should update coupontype" do
    put :update, id: @coupontype, coupontype: { is_active: @coupontype.is_active, name: @coupontype.name }
    assert_redirected_to coupontype_path(assigns(:coupontype))
  end

  test "should destroy coupontype" do
    assert_difference('Coupontype.count', -1) do
      delete :destroy, id: @coupontype
    end

    assert_redirected_to coupontypes_path
  end
end
