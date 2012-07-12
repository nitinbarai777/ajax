require 'test_helper'

class MerchantLocationsControllerTest < ActionController::TestCase
  setup do
    @merchant_location = merchant_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:merchant_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create merchant_location" do
    assert_difference('MerchantLocation.count') do
      post :create, merchant_location: { address: @merchant_location.address, contact: @merchant_location.contact, contact_person: @merchant_location.contact_person, email: @merchant_location.email, latitude: @merchant_location.latitude, longitude: @merchant_location.longitude }
    end

    assert_redirected_to merchant_location_path(assigns(:merchant_location))
  end

  test "should show merchant_location" do
    get :show, id: @merchant_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @merchant_location
    assert_response :success
  end

  test "should update merchant_location" do
    put :update, id: @merchant_location, merchant_location: { address: @merchant_location.address, contact: @merchant_location.contact, contact_person: @merchant_location.contact_person, email: @merchant_location.email, latitude: @merchant_location.latitude, longitude: @merchant_location.longitude }
    assert_redirected_to merchant_location_path(assigns(:merchant_location))
  end

  test "should destroy merchant_location" do
    assert_difference('MerchantLocation.count', -1) do
      delete :destroy, id: @merchant_location
    end

    assert_redirected_to merchant_locations_path
  end
end
