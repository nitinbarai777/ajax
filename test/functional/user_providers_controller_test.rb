require 'test_helper'

class UserProvidersControllerTest < ActionController::TestCase
  setup do
    @user_provider = user_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_provider" do
    assert_difference('UserProvider.count') do
      post :create, user_provider: { email: @user_provider.email, mobile_number: @user_provider.mobile_number, username: @user_provider.username }
    end

    assert_redirected_to user_provider_path(assigns(:user_provider))
  end

  test "should show user_provider" do
    get :show, id: @user_provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_provider
    assert_response :success
  end

  test "should update user_provider" do
    put :update, id: @user_provider, user_provider: { email: @user_provider.email, mobile_number: @user_provider.mobile_number, username: @user_provider.username }
    assert_redirected_to user_provider_path(assigns(:user_provider))
  end

  test "should destroy user_provider" do
    assert_difference('UserProvider.count', -1) do
      delete :destroy, id: @user_provider
    end

    assert_redirected_to user_providers_path
  end
end
