# class UsersController < ApplicationController
#   def edit
#     find_user
#   end

#   def update
#     find_user
#     if @user.update(user_params)
#       redirect_to dashboard_path
#     else
#       render :edit
#     end
#   end

#   private

#   def user_params
#     params.require(:user).permit(:photo)
#   end

#   def find_user
#     @user = current_user
#   end
# end
