require 'test_helper'

class ChatroomControllerTest < ActionDispatch::IntegrationTest
  test "should get get_online_users" do
    get chatroom_get_online_users_url
    assert_response :success
  end

end
