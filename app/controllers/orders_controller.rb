class OrdersController < ApplicationController
  def index
    user = current_user
    if user
      @orders = user.orders
      render :index, status: :ok
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    items = params[:items] || []
    @order = Order.new(
      user_id: current_user.id,
      customer_email: current_user.email,
      status: :pending,
      customer_name: current_user.name,
      order_date: DateTime.now,
      payment_status: false,
    )

    if @order.save
      items.each do |item|
        OrderItem.create(
          order_id: @order.id,
          menu_item_id: item[:menu_item_id],
          quantity: item[:quantity],
          unit_price: item[:unit_price]
        )
      end

      @order.update(total_price: @order.calculate_total_price)

      render :show
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end

    # @order = Order.create(
    #   user_id: current_user.id,
    #   customer_email: current_user.email,
    #   status: params[:status],
    #   customer_name: current_user.name,
    #   total_price: params[:total_price],
    #   order_date: DateTime.now,
    #   payment_status: false,
    # )
    # if @order.persisted?
    #   render :show
    # else
    #   render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    # end
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

  def destroy
    @order = Order.find_by(id: params[:id])
    @order.destroy
    render json: { message: "Order destroyed successfully" }
  end

  private

  def order_update_params
    params.permit(:status, :payment_status)
  end
end
