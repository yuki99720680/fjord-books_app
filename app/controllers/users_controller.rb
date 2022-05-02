# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @users = User.order(:id).page(params[:page]).per(1)
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :postal_code, :address, :bio)
  end

  def render_not_found
    respond_to do |format|
      format.html { render file: 'public/404.html', layout: false, status: :not_found }
    end
  end
end
