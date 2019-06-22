require 'test_helper'

class CheckersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get checkers_new_url
    assert_response :success
  end

  test "should get index" do
    get checkers_index_url
    assert_response :success
  end

  test "should get edit" do
    get checkers_edit_url
    assert_response :success
  end

  test "should get show" do
    get checkers_show_url
    assert_response :success
  end

end
