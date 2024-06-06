require "test_helper"

class ExchangeRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get exchange_requests_create_url
    assert_response :success
  end
end
