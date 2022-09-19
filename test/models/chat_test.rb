require "test_helper"

class ChatTest < ActiveSupport::TestCase
  def setup
    @chat_blank = Chat.create
    @chat_filled = Chat.create(
      username: "sea123",
      text: "testing is fun",
    )
    @chat_filled_2 = Chat.create(
      username: "sea123",
      text: "another chat",
    )
    @chat_filled_3 = Chat.create(
      username: "sea123",
      text: "another chat",
      timeout: 120
    )
  end

  test "username is required" do
    assert @chat_blank.errors.full_messages.include?("Username can't be blank")
  end

  test "text is required" do
    assert @chat_blank.errors.full_messages.include?("Text can't be blank")
  end

  test "saves with valid fields" do
    assert @chat_filled.valid?
    assert @chat_filled.id.present?
  end

  test "expiration_date defaults to 60 seconds" do
    assert_equal @chat_filled_2.expiration_date, @chat_filled_2.created_at + 60.seconds
  end

  test "expiration_date is set to created_at + timeout" do
    assert_equal @chat_filled_3.expiration_date, @chat_filled_3.created_at + 120.seconds
  end

  test "json for index format" do
    json = @chat_filled.as_json({index: true})

    assert_equal json[:username], "sea123"
    assert_equal json[:text], "testing is fun"
    assert json[:expiration_date]
    assert_equal json[:is_read], false
    assert !json[:id]
  end

  test "json for username format" do
    json = @chat_filled.as_json({username: true})

    assert json[:id]
    assert_equal json[:text], "testing is fun"
    assert_equal json[:is_read], false
    assert !json[:username]
    assert !json[:expiration_date]
  end

  test "json for show format" do
    json = @chat_filled.as_json({show: true})

    assert_equal json[:username], "sea123"
    assert_equal json[:text], "testing is fun"
    assert json[:expiration_date]
    assert_equal json[:is_read], false
    assert !json[:id]
  end

  test "json for create format" do
    json = @chat_filled.as_json({create: true})
    assert json[:id]
    assert !json[:username]
    assert !json[:text]
    assert !json[:expiration_date]
    assert !json[:is_read]
  end
end
