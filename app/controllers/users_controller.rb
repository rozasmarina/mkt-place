# class UsersController < ApplicationController
#   before_action :set_user, only: %i[show create]
  
#   def new
#     @user = User.new
#   end

#   private

#   def users_params
#     params.require(:user).permit(:first_name, :last_name, :address, :phone_number, :username, :email, :cpf)
#   end

#   def set_user
#     @user = User.find(params[:id])
#   end
# end
