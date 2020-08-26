class UsersController < ApplicationController
  before_action :search_form

  def show
    @user = User.find(params[:id])
  end
end
