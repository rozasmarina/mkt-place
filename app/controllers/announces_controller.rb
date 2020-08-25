class AnnouncesController < ApplicationController
  before_action :set_announce, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @search = params['search']
    @name = @search["name"]
    if @search.present? && @name != ''
      @announces = Announce.where("lower(product_name) ILIKE ?", "%#{@name.downcase}%")
    else
      @announces = Announce.all
      @gallery_announces = Announce.where("announce_type = ?", "gallery")
      @highlight_announces = Announce.where("announce_type = ?", "highlight")
      @top_announces = Announce.where("announce_type = ?", "top")
      @free_announces = Announce.where("announce_type = ?", "free")
    end
  end

  def new
    @user = User.find(params[:user_id])
    @announce = Announce.new
  end

  def create
    @user = User.find(params[:user_id])
    @announce = Announce.new(announce_params)
    @announce.user = @user
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
    @announce.destroy
    redirect_to root_path
  end

  private

  def announce_params
    params.require(:announce).permit(:announce_type, :quantity, :price, :product_name, :product_category, :product_description, :active)
  end

  def set_announce
    @announce = Announce.find(params[:id])
  end
end
