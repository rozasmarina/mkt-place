class AnnouncesController < ApplicationController
  before_action :set_announce, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @search = params['search']
    if @search.present? && @search["name"] != ''
      @name = @search["name"]
      query = "product_name @@ :query
              OR product_description @@ :query"
      # @@ => full text search do postgresql. O ILIKE nao pega palavra a palavra
      # trigrams search => ao inves de pegar palavra em palavra, quebra de 3 em 3 letras
      # para usar trigrams no postgresql, usar a gem PG SEARCH
      @announces = Announce.where(query, query: "%#{@name}%")
    else
      @announces = Announce.all
      @gallery_announces = Announce.where("announce_type = ?", "Gallery")
      @highlight_announces = Announce.where("announce_type = ?", "Highlight")
      @top_announces = Announce.where("announce_type = ?", "Top")
      @free_announces = Announce.where("announce_type = ?", "Free")
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
    owner_check
  end

  def update
    owner_check
    @announce.update(announce_params)
    redirect_to @announce
  end

  def destroy
    owner_check
    @announce.destroy
    redirect_to root_path
  end

  private

  def announce_params
    params.require(:announce).permit(
      :announce_type,
      :quantity,
      :price,
      :product_name,
      :product_category,
      :product_description,
      :active,
      :photo
    )
  end

  def set_announce
    @announce = Announce.find(params[:id])
  end

  def owner_check
    redirect_to announces_path unless @announce.user == current_user
  end
end
