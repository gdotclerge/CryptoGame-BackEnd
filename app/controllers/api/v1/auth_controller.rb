class Api::V1::AuthController < ApplicationController
  before_action :authorize_user!, only: [:show]

   def show
     render json: current_user
   end

   def create
     # see if there is a user with this username
     user = User.find_by(username: params[:username])
     # if there is, make sure that they have the correct password
     if user.present? && user.authenticate(params[:password])
       # if they do, render back a json response of the user info
       # issue token
       created_jwt = issue_token({id: user.id})
       render json: {user: user, jwt: created_jwt}
     else
       # otherwise, render back some error response
       render json: {
         error: 'Username or password incorrect'
       }, status: 404
     end
   end


   def signUp
     @user = User.new(user_params)
     if @user.save
       created_jwt = issue_token({id: @user.id})
       render json: {user: @user, jwt: created_jwt}
     else
       render json: {errors: @user.errors.full_messages}, status: 422
     end
   end


   private

   def user_params
     params.require(:user).permit(
       :username,
       :first_name,
       :last_name,
       :password,
       :password_confirmation
     )
   end
end
