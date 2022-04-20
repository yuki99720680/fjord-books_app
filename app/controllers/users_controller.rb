class UsersController < ApplicationController
  def index
    @users = User.order(:id).page(params[:page]).per(1)
  end

  def show
    @user = User.find(params[:id])
  end
end
