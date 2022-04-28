class FollowingsController < ApplicationController
  before_action :set_user, only: %i[create destroy]

  def index; end
  # current_user.following

  def create
    redirect_to request.referer, notice: 'フォローしたよ！' if current_user.following.create(follower_id: @user.id)
  end

  def destroy
    redirect_to request.referer, notice: 'フォロー解除したよ！' if current_user.following.find_by(follower_id: @user.id).destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
