class CommentsController < ApplicationController
  before_action :authenticate_user!

  def comment_an_outfit
    unless params[:comment] ==  nil
      comment = Comment.new
      comment.user_id = current_user.id
      comment.outfit_id = params[:outfit_id]
      comment.comment = params[:comment]
      if comment.save
        render json: {status: 0, data: nil}
      else
        render json: {status: 1, data: nil}
      end
    end
  end

end
