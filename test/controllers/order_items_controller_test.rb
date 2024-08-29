require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/order_items.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal OrderItem.count, data.length
  end
end
