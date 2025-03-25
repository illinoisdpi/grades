require "test_helper"

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get resources_show_url
    assert_response :success
  end

  test "should get edit" do
    get resources_edit_url
    assert_response :success
  end

  test "should get update" do
    get resources_update_url
    assert_response :success
  end
end
