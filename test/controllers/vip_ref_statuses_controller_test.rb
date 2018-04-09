require 'test_helper'

class VipRefStatusesControllerTest < ActionController::TestCase
  setup do
    @vip_ref_status = vip_ref_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vip_ref_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vip_ref_status" do
    assert_difference('VipRefStatus.count') do
      post :create, vip_ref_status: {  }
    end

    assert_redirected_to vip_ref_status_path(assigns(:vip_ref_status))
  end

  test "should show vip_ref_status" do
    get :show, id: @vip_ref_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vip_ref_status
    assert_response :success
  end

  test "should update vip_ref_status" do
    patch :update, id: @vip_ref_status, vip_ref_status: {  }
    assert_redirected_to vip_ref_status_path(assigns(:vip_ref_status))
  end

  test "should destroy vip_ref_status" do
    assert_difference('VipRefStatus.count', -1) do
      delete :destroy, id: @vip_ref_status
    end

    assert_redirected_to vip_ref_statuses_path
  end
end
