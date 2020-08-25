class AnnouncesController < ApplicationController
  before_action :set_announce, only: %i[show edit update destroy]

  def index
    @announces = Announce.all
    @gallery_announces = Announce.where("announce_type = ?", "gallery")
    @highlight_announces = Announce.where("announce_type = ?", "highlight")
    @top_announces = Announce.where("announce_type = ?", "top")
    @free_announces = Announce.where("announce_type = ?", "free")
  end

  def show
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

  def edit
  end

  def update
    @annouce.update(announce_params)
    redirect_to announce_path(@announce)
  end

  def destroy
    @announce.destroy
    redirect_to root_path
  end

  private

  def announce_params
    params.require(:announce).permit(:user_id, :announce_type, :quantity, :price, :product_name, :product_category, :product_description, :active)
  end

  def set_announce
    @announce = Announce.find(params[:id])
  end
end
