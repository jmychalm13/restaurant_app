class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render :index
  end
end
