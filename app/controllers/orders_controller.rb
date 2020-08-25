class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(cocktail_params)
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end
end
