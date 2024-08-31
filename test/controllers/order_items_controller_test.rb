require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      name: "Jane",
      email: "jane@test.com",
      password: "password",
      password_confirmation: "password"
    )
    post "/sessions.json", params: {email: "jane@test.com", password: "password"}
    data = JSON.parse(response.body)
    @jwt = data["jwt"]
    @order = Order.create(
      user_id: @user.id,
      customer_email: @user.email,
      status: :pending,
      customer_name: @user.name,
      total_price: 9.99,
      order_date: DateTime.now(),
      payment_status: false,
    )
    @menu_item = MenuItem.create(
      name: "bread sticks",
      category: :appetizer,
      price: 8.99,
      description: "garlic bread",
      availability: true,
    )
  end
  test "index" do
    get "/order_items.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal OrderItem.count, data.length
  end

  test "create" do
    assert_difference "OrderItem.count", 1 do
      post "/order_items.json", params: {
        order_id: @order.id,
        menu_item_id: @menu_item.id,
        quantity: 2,
        unit_price: @menu_item.price
      }, headers: {
        "Authorization" => "Bearer #{@jwt}"
      }
    end
  end

  test "show" do
    get "/order_items/#{OrderItem.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "order_id", "menu_item_id", "quantity", "unit_price"], data.keys
  end

  test "destroy" do
    assert_difference "OrderItem.count", -1 do
      delete "/order_items/#{OrderItem.first.id}.json"
      assert_response 200
    end
  end
end
