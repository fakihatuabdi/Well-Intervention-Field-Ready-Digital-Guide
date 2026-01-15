require "test_helper"

class ChatBotControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chat_bot_index_url
    assert_response :success
  end
end
