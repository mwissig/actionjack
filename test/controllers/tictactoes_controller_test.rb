require 'test_helper'

class TictactoesControllerTest < ActionDispatch::IntegrationTest
  test "should get play" do
    get tictactoes_play_url
    assert_response :success
  end

end
