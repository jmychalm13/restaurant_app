class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
    render :index
  end

  def create
    @order_item = OrderItem.create(
      order_id: params[:order_id],
      menu_item_id: params[:menu_item_id],
      quantity: params[:quantity],
      unit_price: params[:unit_price]
    )
    if @order_item.save
      render :show
    else
      render json: {errors: @order_item.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @order_item = OrderItem.find_by(id: params[:id])
    render :show
  end

  def destroy
    @order_item = OrderItem.find_by(id: params[:id])
    @order_item.destroy
    render json: { message: "OrderItem destroyed successfully" }
  end
end



