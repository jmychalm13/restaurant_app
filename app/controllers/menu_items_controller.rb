class MenuItemsController < ApplicationController
  def index
    @menu_items = MenuItem.all
    render :index
  end

  def create
    @menu_item = MenuItem.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      availability: params[:availability],
      category: params[:category],
    )
    render :show
  end

  def show
    @menu_item = MenuItem.find_by(id: params[:id])
    render :show
  end

  def update
    @menu_item = MenuItem.find_by(id: params[:id])
    @menu_item.update(
      name: params[:name] || @menu_item.name,
      description: params[:description] || @menu_item.description,
      price: params[:price] || @menu_item.price,
      availability: params[:availability] || @menu_item.availability,
      category: params[:category] || @menu_item.category,
    )
    render :show
  end

  def destroy
    @menu_item = MenuItem.find_by(id: params[:id])
    @menu_item.destroy
    render json: { message: "Item destroyed successfully" }
  end
end
