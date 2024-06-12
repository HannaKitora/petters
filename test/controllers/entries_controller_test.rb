require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get entries_new_url
    assert_response :success
  end

  test "should get confirm" do
    get entries_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get entries_thanks_url
    assert_response :success
  end

  test "should get create" do
    get entries_create_url
    assert_response :success
  end

  test "should get index" do
    get entries_index_url
    assert_response :success
  end

  test "should get show" do
    get entries_show_url
    assert_response :success
  end
end
