require 'test_helper'

class TictactoeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tictactoe_new_url
    assert_response :success
  end

  test "should get edit" do
    get tictactoe_edit_url
    assert_response :success
  end

  test "should get index" do
    get tictactoe_index_url
    assert_response :success
  end

  test "should get show" do
    get tictactoe_show_url
    assert_response :success
  end

end
