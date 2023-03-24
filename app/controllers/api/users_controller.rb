class Api::UsersController < ApplicationController
  wrap_parameters include: User.attribute_names + ['password']

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      render :show
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end

  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render 'api/users/single'
    else
      render json: {message: "User not found"}, status: 404
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
end
