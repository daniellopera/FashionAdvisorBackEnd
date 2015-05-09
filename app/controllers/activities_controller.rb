class ActivitiesController < ApplicationController
  include HashFormatterHelper
  before_action :authenticate_user!
  #GET /user/feed
  #No params
  def following_activities
    following_list = current_user.following
    if following_list.blank?
      render json: {status: 0, data: nil}
    else
      activities = Activity.bring_following_activities(following_list)
      formatted_activities = format_activities_hash(activities)

      render json: {status: 0, data: formatted_activities.take(10)}
    end


  end

end
