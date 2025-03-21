require "test_helper"

class PageControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get page_landing_url
    assert_response :success
  end
end
