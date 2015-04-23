class CommentsController < ApplicationController
  before_action :authenticate_user!
  include ShopStyleApiHelper
  include HashFormatterHelper
  #POST /comments/comment
  #{"outfit_id": "X", "comment":"XXXX"}
  def comment_an_outfit
    unless params[:comment] ==  nil
      comment = Comment.new
      comment.user_id = current_user.id
      comment.outfit_id = params[:outfit_id]
      comment.comment = params[:comment]
      if comment.save
        array = []
        array << comment
        comments_array = format_comments_hash(array)
        render json: {status: 0, data: comments_array}
      else
        render json: {status: 1, data: nil}
      end
    end
  end


end
