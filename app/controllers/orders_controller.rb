class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(orders_params)
    if @order.save
      redirect_to @order
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:price, :quantity, :announce, :user)
  end
end
