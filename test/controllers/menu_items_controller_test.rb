require "test_helper"

class MenuItemsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/menu_items.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal MenuItem.count, data.length
  end
end
