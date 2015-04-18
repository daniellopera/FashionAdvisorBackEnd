class RatingsController < ApplicationController

  include HashFormatterHelper
  before_action :authenticate_user!

  def rate_an_outfit
    unless params[:rate] ==  nil
      rating = Rating.new
      rating.user_id = current_user.id
      rating.outfit_id = params[:outfit_id]
      rating.rating = params[:rating].to_i
      if rating.save
        render json: {status: 0, data: nil}
      else
        render json: {status: 1, data: nil}
      end
    end
  end
end
