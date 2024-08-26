class Order < ApplicationRecord
  validates :user, presence: true
  enum status: {pending: 0, confirmed: 1, preparing: 2, ready: 3, completed: 4, canceled: 5}
  belongs_to :user
end
