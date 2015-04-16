class UsersController < ApplicationController

  def search
    emails = User.where("email LIKE ?", "%#{params[:email]}%").select('id', 'email')
    if emails.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: {user: emails}}
    end
  end
end
