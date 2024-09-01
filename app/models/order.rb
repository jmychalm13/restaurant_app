class Order < ApplicationRecord
  validates :user, presence: true
  enum status: {pending: 0, confirmed: 1, preparing: 2, ready: 3, completed: 4, canceled: 5}
  belongs_to :user
  has_many :order_items

  def calculate_total_price
    total_price = 0
    order_items.each do |item|
      total_price += item.unit_price * item.quantity
    end
    return total_price
  end
end
