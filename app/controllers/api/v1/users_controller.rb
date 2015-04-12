class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    respond_with @users
  end

  def show
    user = User.find(params[:id])
    respond_with User.find(params[:id])
  rescue
    render json: { message: "Not found" }, status: 404
  end

  def create
    user = User.new(user_params)
    if user.save
      # respond_with user, status: 201
      render json: user, status: 201
    else
      # respond_with { errors: user.errors }, status: 422
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    User.find(params[:id]).delete
    render json: { message: "User deleted successfully" }, status: 204
  rescue
    render json: { message: "User not found" }, status: 404
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 400
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'User not found' }, status: 404
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :birthdate, :password, :password_confirmation)
  end
end
