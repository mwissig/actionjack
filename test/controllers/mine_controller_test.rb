require 'test_helper'

class MineControllerTest < ActionDispatch::IntegrationTest
  test "should get move" do
    get mine_move_url
    assert_response :success
  end

  test "should get dig" do
    get mine_dig_url
    assert_response :success
  end

  test "should get place" do
    get mine_place_url
    assert_response :success
  end

end
