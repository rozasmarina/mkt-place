class AnnouncesController < ApplicationController
  before_action :set_announce, only: [:show, :edit, :update, :destroy]
  
  def index
    @announces = Announce.all  
  end

  def new
    @announce = Announce.new
  end

  def create
    @announce = Announce.new(announce_params)
    if @announce.save
      redirect_to announce_path(@announce)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def announce_params
    params.require(:announce).permit(:user_id, :announce_type, :quantity, :price, :product_name, :product_category, :product_description, :active)
  end

  def set_announce
    @announce = Announce.find(params[:id])
  end
end
