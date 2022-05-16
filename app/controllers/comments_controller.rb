# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]

  def create
    @commentable.comments.create(comment_params)
    redirect_to request.referer, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def destroy
    current_user.comments.find(params[:id]).destroy
    redirect_to request.referer, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
