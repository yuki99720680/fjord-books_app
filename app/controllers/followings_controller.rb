# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :set_user, only: %i[index create destroy]

  def index
    following_ids = @user.following_ids
    @users = User.where(id: following_ids)
  end

  def create
    if current_user == @user
      redirect_to request.referer, notice: 'それ自分'
    elsif current_user.following.create(follower_id: @user.id)
      redirect_to request.referer, notice: 'フォローしたよ！'
    end
  end

  def destroy
    if current_user == @user
      redirect_to request.referer, notice: 'それ自分'
    elsif current_user.following.find_by(follower_id: @user.id).destroy
      redirect_to request.referer, notice: 'フォロー解除したよ！'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
