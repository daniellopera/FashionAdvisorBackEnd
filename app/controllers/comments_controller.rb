class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    comment = Comment.new create_params
    comment.user = current_user

    if comment.save
       render json: {
         success: true
       }
     else
       render json: {
         success: false
       }
     end
  end

    def create_params
      params.require(:comment).permit(
        :outfit_id,
        :comment
        )
    end
end
