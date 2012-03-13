require 'test_helper'

class PostingsControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get my" do
    get :my
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

end
