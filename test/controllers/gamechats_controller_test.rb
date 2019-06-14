require 'test_helper'

class GamechatsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get gamechats_new_url
    assert_response :success
  end

  test "should get index" do
    get gamechats_index_url
    assert_response :success
  end

  test "should get edit" do
    get gamechats_edit_url
    assert_response :success
  end

  test "should get show" do
    get gamechats_show_url
    assert_response :success
  end

end
