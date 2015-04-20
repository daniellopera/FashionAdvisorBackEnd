class RatingsController < ApplicationController

  include HashFormatterHelper
  before_action :authenticate_user!

  #POST 'rating/rate'
  #params
  #rate = 0 (dislike) or 1 (like)
  #outfit_id
  def rate_an_outfit
    unless params[:rate] ==  nil
      rating = Rating.new
      rating.user_id = current_user.id
      rating.outfit_id = params[:outfit_id]
      #validates if the rate is 0 or 1
      if params[:rate].to_i == 1
        rating.rating = 1
      elsif(params[:rate].to_i == 0)
        rating.rating = 0
      end
      if rating.save
        #it saved, which means it's a new like from that user to that outfit
        answer = rating.new_likes(params[:outfit_id], params[:rate])
        render json: {status: answer, data: nil}
      else
        #it didn't save, which means there was already a like/dislike from that user to that outfit
        answer = rating.update_likes(params[:outfit_id], params[:rate], current_user.id)
        render json: {status: answer, data: nil}
      end
    end
  end

  #GET user/ratings
  #params
  #user_id
  def get_ratings_from_a_user
    ratings = []
    format_ratings_hash(ratings, params[:user_id].to_i)
    render json: {status: 0, data: {ratings: ratings}}
  end



end
