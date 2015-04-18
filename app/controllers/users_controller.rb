class UsersController < ApplicationController

  def search
    usernames = User.where("username LIKE ?", "%#{params[:user_name]}%").select('id', 'username')
    if emails.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: {users: usernames}}
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

  def view_profile

    user = User.find_by_id(params[:id])
    if user
      if user.outfits.any?
        render json: {status: 0, data: user.outfits}
      else
        render json: {status: 0, data:nil}
      end
    else
      render json: {status: 1, data:nil}
    end
  end


end
