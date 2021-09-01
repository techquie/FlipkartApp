require "test_helper"

class FlipkartControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flipkart_index_url
    assert_response :success
  end

  test "should get show" do
    get flipkart_show_url
    assert_response :success
  end
end
