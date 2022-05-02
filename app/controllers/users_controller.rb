# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.includes(:avatar_blob).order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end
end
