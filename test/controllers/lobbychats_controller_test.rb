require 'test_helper'

class LobbychatsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get lobbychats_new_url
    assert_response :success
  end

  test "should get edit" do
    get lobbychats_edit_url
    assert_response :success
  end

  test "should get index" do
    get lobbychats_index_url
    assert_response :success
  end

  test "should get show" do
    get lobbychats_show_url
    assert_response :success
  end

end
