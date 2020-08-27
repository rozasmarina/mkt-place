class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    redirect_to root_path unless @order.announce.user == current_user
  end

  def new
    @announce = Announce.find(params[:announce_id])
    @order = Order.new
  end

  def create
    @user = current_user
    @announce = Announce.find(params[:announce_id])
    @order = Order.new(order_params)
    @order.user = @user
    @order.price = @announce.price * @order.quantity
    @order.announce = @announce
    if @order.save
      @announce.quantity -= @order.quantity
      @announce.update_attribute(:quantity, @announce.quantity)
      redirect_to announce_path(@announce)
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:quantity)
  end

  def owner_check
    redirect_to announces_path unless @order.user == current_user
  end
end
