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

  test "show" do
    get "/menu_items/#{MenuItem.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "name", "description", "price", "category", "availability"], data.keys
  end

  test "update" do
    menu_item = MenuItem.first
    patch "/menu_items/#{menu_item.id}.json", params: { name: "Updated Menu Item" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated Menu Item", data["name"]
  end

  test "destroy" do
    assert_difference "MenuItem.count", -1 do
      delete "/menu_items/#{MenuItem.first.id}.json"
      assert_response 200
    end
  end
end
