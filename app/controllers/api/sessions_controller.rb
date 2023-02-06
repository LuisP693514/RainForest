class Api::SessionsController < ApplicationController
  def show
    @user = current_user
    
    if @user
      render 'api/users/show'
    else
      render json: {user: nil}
    end
     # current_user ? render json: {user: current_user} :  render json: {user: nil}
 
   end
 
   def create
     # debugger
     @user = User.find_by_credentials(params[:credential], params[:password])
 
     if @user
       # debugger
       login!(@user)
       render 'api/users/show'
     else
       if User.find_by(email: params[:credential])
        render json: {errors: ['Password was incorrect']}, status: :unauthorized
       else
        render json: {errors: ['We cannot find an account with that email address.']}, status: :unauthorized
       end
     end
   end
 
   def destroy
     logout! if current_user
     render json: ['you have successfuly logged out :)']
   end
end
