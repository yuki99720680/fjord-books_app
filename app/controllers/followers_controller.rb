# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :set_user, only: %i[index]

  def index
    @users = @user.follower_user
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
