require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
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
  end

  test "index" do
    get "/orders.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Order.count, data.length
  end

  test "create" do
    assert_difference "Order.count", 1 do
      post "/orders.json", params: {
        user_id: @user.id,
        customer_email: @user.email,
        status: :pending,
        customer_name: @user.name,
        total_price: 9.99,
        order_date: DateTime.now,
        payment_status: false,
      }, headers: {
        "Authorization" => "Bearer #{@jwt}"
      }
      assert_response 200
    end
  end
end
