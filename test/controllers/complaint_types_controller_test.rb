require 'test_helper'

class ComplaintTypesControllerTest < ActionController::TestCase
  setup do
    @complaint_type = complaint_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:complaint_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create complaint_type" do
    assert_difference('ComplaintType.count') do
      post :create, complaint_type: { handler_id: @complaint_type.handler_id, level: @complaint_type.level, problem: @complaint_type.problem, solution: @complaint_type.solution }
    end

    assert_redirected_to complaint_type_path(assigns(:complaint_type))
  end

  test "should show complaint_type" do
    get :show, id: @complaint_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @complaint_type
    assert_response :success
  end

  test "should update complaint_type" do
    patch :update, id: @complaint_type, complaint_type: { handler_id: @complaint_type.handler_id, level: @complaint_type.level, problem: @complaint_type.problem, solution: @complaint_type.solution }
    assert_redirected_to complaint_type_path(assigns(:complaint_type))
  end

  test "should destroy complaint_type" do
    assert_difference('ComplaintType.count', -1) do
      delete :destroy, id: @complaint_type
    end

    assert_redirected_to complaint_types_path
  end
end
