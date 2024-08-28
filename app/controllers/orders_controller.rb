class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render :index
  end

  def create
    @order = Order.create(
      user_id: current_user.id,
      customer_email: current_user.email,
      status: params[:status],
      customer_name: current_user.name,
      total_price: params[:total_price],
      order_date: DateTime.now,
      payment_status: false,
    )
    if @order.persisted?
      render :show
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
    render :show
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.update(order_update_params)
      render :show
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def order_update_params
    params.permit(:status, :payment_status)
  end
end
# json.id order.id
# json.customer_email order.customer_email
# json.status order.status
# json.customer_name order.customer_name
# json.total_price order.total_price
# json.order_date order.order_date
# json.payment_status order.payment_status
