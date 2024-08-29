class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
    render :index
  end
end
