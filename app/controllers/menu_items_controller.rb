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
end
