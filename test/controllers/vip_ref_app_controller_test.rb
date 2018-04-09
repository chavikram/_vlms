require 'test_helper'

class VipRefAppControllerTest < ActionController::TestCase
  test "should get inbox" do
    get :inbox
    assert_response :success
  end

  test "should get draft" do
    get :draft
    assert_response :success
  end

  test "should get sent" do
    get :sent
    assert_response :success
  end

end
