# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :set_user, only: %i[index create destroy]

  def index
    @users = @user.following_user
  end

  def create
    notice = if current_user == @user
               '自分自身はフォローできません。'
             elsif current_user.following.create(follower_id: @user.id).id.nil?
               'フォロー済みです。'
             else
               'フォローしました。'
             end
    redirect_to request.referer, notice: notice
  end

  def destroy
    notice = if current_user == @user
               '自分自身はフォローできません。'
             elsif current_user.following.find_by(follower_id: @user.id).nil?
               'フォローしていません。'
             elsif current_user.following.find_by(follower_id: @user.id).destroy
               'フォロー解除しました。'
             end
    redirect_to request.referer, notice: notice
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
