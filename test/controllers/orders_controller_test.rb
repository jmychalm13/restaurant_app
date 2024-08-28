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
    @order = Order.create(
      user_id: @user.id,
      customer_email: @user.email,
      status: :pending,
      customer_name: @user.name,
      total_price: 9.99,
      order_date: DateTime.now(),
      payment_status: false,
    )
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

  test "show" do
    get "/orders/#{Order.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "user_id", "customer_email", "status", "customer_name", "total_price", "order_date", "payment_status"], data.keys
  end

  test "update" do
    patch "/orders/#{@order.id}.json", params: {
      status: :confirmed
    }, headers: {
      "Authorization" => "Bearer #{@jwt}"
    }
    assert_response 200
    data = JSON.parse(response.body)
    assert_equal "confirmed", data["status"]
  end

  test "destroy" do
    assert_difference "Order.count", -1 do
      delete "/orders/#{Order.first.id}.json"
      assert_response 200
    end
  end
end
