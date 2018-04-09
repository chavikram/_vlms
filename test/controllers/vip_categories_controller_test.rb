require 'test_helper'

class VipCategoriesControllerTest < ActionController::TestCase
  setup do
    @vip_category = vip_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vip_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vip_category" do
    assert_difference('VipCategory.count') do
      post :create, vip_category: {  }
    end

    assert_redirected_to vip_category_path(assigns(:vip_category))
  end

  test "should show vip_category" do
    get :show, id: @vip_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vip_category
    assert_response :success
  end

  test "should update vip_category" do
    patch :update, id: @vip_category, vip_category: {  }
    assert_redirected_to vip_category_path(assigns(:vip_category))
  end

  test "should destroy vip_category" do
    assert_difference('VipCategory.count', -1) do
      delete :destroy, id: @vip_category
    end

    assert_redirected_to vip_categories_path
  end
end
