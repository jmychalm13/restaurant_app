require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @menu_item = menu_items(:one)

    @order = Order.create(
      user: @user,
      customer_name: @user.name,
      customer_email: @user.email,
      status: :pending,
      order_date: DateTime.now,
      payment_status: false,
    )

    @order.order_items.create!(menu_item_id: @menu_item.id, quantity: 2, unit_price: @menu_item.price)
  end

  test "calculate total price" do
    expected_total_price = 2 * 9.99
    assert_equal expected_total_price, @order.calculate_total_price
  end
end
