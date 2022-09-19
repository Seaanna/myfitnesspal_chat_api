require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat = chats(:one)
  end

  test "should get index" do
    get chats_url, as: :json
    assert_response :success
  end

  test "should create chat" do
    assert_difference("Chat.count") do
      post chats_url, params: { chat: { is_read: @chat.is_read, text: @chat.text, timeout: @chat.timeout, username: @chat.username } }, as: :json
    end

    assert_response :created
    assert_equal @response.status, 201
    assert @response.body.include?('id')
    assert !@response.body.include?('username')
  end

  test "should show chat" do
    get chat_url(@chat), as: :json
    assert_response :success

    assert_equal @response.status, 200
    assert !@response.body.include?('id')
    assert @response.body.include?('username')
    assert @response.body.include?('text')
    assert @response.body.include?('expiration_date')
    assert @response.body.include?('is_read')
  end

  test "should get chat by username" do
    @chat = Chat.create(username: "sea123", text: "testing")

    get chats_by_username_url('sea123'), as: :json
    assert_response :success

    assert_equal @response.status, 200
    assert @response.body.include?('id')
    assert @response.body.include?('text')
    assert @response.body.include?('is_read')
    assert !@response.body.include?('username')
  end

  test "should not get expired messages for chats by username" do
    @chat = Chat.create(username: "sea123", text: "testing", timeout: 0)

    get chats_by_username_url('sea123'), as: :json
    assert_response :success

    assert_equal @response.body, '[]'
  end

  test "should not get read messages for chats by username" do
    @chat = Chat.create(username: "sea123", text: "testing", is_read: true)

    get chats_by_username_url('sea123'), as: :json
    assert_response :success

    assert_equal @response.body, '[]'
  end

  test "should update chat" do
    patch chat_url(@chat), params: { chat: { is_read: @chat.is_read, text: @chat.text, timeout: @chat.timeout, username: @chat.username } }, as: :json
    assert_response :success
  end

  test "should destroy chat" do
    assert_difference("Chat.count", -1) do
      delete chat_url(@chat), as: :json
    end

    assert_response :no_content
  end
end
