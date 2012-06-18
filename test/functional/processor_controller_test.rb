require 'test_helper'

class ProcessorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get download" do
    get :download
    assert_response :success
  end

  test "should get decode" do
    get :decode
    assert_response :success
  end

  test "should get extract" do
    get :extract
    assert_response :success
  end

  test "should get assign" do
    get :assign
    assert_response :success
  end

end
