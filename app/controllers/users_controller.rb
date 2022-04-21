# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.order(:id).page(params[:page]).per(1)
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: '[TEST MASSAGE] User update success.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :postal_code, :address, :bio)
  end
end
