class UsersController < ApplicationController

  def search
    emails = User.where("email LIKE ?", "%#{params[:email]}%").select('id', 'email')
    if emails.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: {user: emails}}
    end
  end

  def following_users
    user = User.find(current_user.id)
    following_list = user.following.select('id', 'email')
    if following_list.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: following_list}
    end

  end

  def followers_users
    user = User.find(current_user.id)
    followers_list = user.followers.select('id', 'email')
    if followers_list.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: followers_list}
    end
  end

  def follow_an_user
    user_to_follow = User.find_by_id(params[:user_id])
    if current_user.following.find_by_id(user_to_follow.id) == nil
      current_user.following << user_to_follow
      render json: {status: 0, data: nil}
    else
      render json: {status: 1, data: nil}
    end
  end

end


