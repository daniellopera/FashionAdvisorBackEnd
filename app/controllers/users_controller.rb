class UsersController < ApplicationController

  def search
    emails = User.where("email LIKE ?", "%#{params[:email]}%").select('id', 'email')
    if emails.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: {user: emails}}
    end
  end

  def follow
    user = User.find(1)
    following = user.follower
    render json: {status: 1, data: following}
  end
end


