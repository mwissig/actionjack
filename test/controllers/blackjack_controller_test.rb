require 'test_helper'

class BlackjackControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get blackjack_new_url
    assert_response :success
  end

  test "should get edit" do
    get blackjack_edit_url
    assert_response :success
  end

  test "should get index" do
    get blackjack_index_url
    assert_response :success
  end

  test "should get show" do
    get blackjack_show_url
    assert_response :success
  end

end
