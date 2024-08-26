puts "Seeding Started"

categories = MenuItem.categories.keys

10.times do
  MenuItem.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Commerce.price(range: 5.0..50.0),
    category: categories.sample,
    availability: [true, false].sample
  )
end

puts "Seeding complete"
