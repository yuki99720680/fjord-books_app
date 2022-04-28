# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :set_user, only: %i[index]

  def index
    follower_ids = @user.follower_ids
    @users = User.where(id: follower_ids)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
