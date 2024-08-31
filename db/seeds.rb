puts "Seeding Started"

# categories = MenuItem.categories.keys
statuses = Order.statuses.keys

# 10.times do
#   MenuItem.create!(
#     name: Faker::Food.dish,
#     description: Faker::Food.description,
#     price: Faker::Commerce.price(range: 5.0..50.0),
#     category: categories.sample,
#     availability: [true, false].sample
#   )
# end
# 
# User.create(
#   name: "Jane",
#   email: "jane@test.com",
#   password: "password",
#   password_confirmation: "password"
# )

dan = User.create(
  name: "Dan",
  email: "dan@test.com",
  password: "password",
  password_confirmation: "password"
)

dans_order = Order.create(
  user_id: dan.id,
  customer_name: dan.name,
  customer_email: dan.email,
  status: statuses.sample,
  total_price: 15.00,
  order_date: DateTime.now,
  payment_status: false,
)

OrderItem.create(
  order_id: dans_order.id,
  menu_item_id: MenuItem.last.id,
  quantity: 3,
  unit_price: 7.50
)

# Order.create(
#   user_id: User.first.id,
#   customer_name: User.first.name,
#   customer_email: User.first.email,
#   status: statuses.sample,
#   total_price: 10.00,
#   order_date: DateTime.now,
#   payment_status: false
# )

# OrderItem.create(
#   order_id: Order.first.id,
#   menu_item_id: MenuItem.first.id,
#   quantity: 2,
#   unit_price: 1.99
# )

puts "Seeding complete"
