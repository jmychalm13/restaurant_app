class MenuItem < ApplicationRecord
  enum category: {appetizer: 0, main_course: 1, dessert: 2, beverage: 3}
end
