class Order < ApplicationRecord
  enum status: {pending: 0, confirmed: 1, preparing: 2, ready: 3, completed: 4, canceled: 5}
end
