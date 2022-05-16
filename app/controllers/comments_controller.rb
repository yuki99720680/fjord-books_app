# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create]

  def create
    @commentable.comments.create(comment_params)
    redirect_to request.referer, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def destroy
    comment = Comment.find(params[:id])
    if current_user == comment.user
      comment.destroy
      notice = t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      alert = t('controllers.common.alert_destroy_resource_of_other_user', name: Comment.model_name.human)
    end
    redirect_to request.referer, notice: notice, alert: alert
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
