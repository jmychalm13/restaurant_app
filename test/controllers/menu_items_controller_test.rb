require "test_helper"

class MenuItemsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/menu_items.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal MenuItem.count, data.length
  end

  test "create" do
    assert_difference "MenuItem.count", 1 do
      post "/menu_items.json", params: {
        name: "bread sticks",
        category: :appetizer,
        price: 8.99,
        description: "garlic bread",
        availability: true,
      }
      assert_response 200
    end
  end
end
