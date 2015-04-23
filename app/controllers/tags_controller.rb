class TagsController < ApplicationController
  before_action :authenticate_user!


  def create_tags
    unless params[:tags] ==  nil
      tags = params[:tags]
      outfit_id = params[:outfit_id]
      tag = Tag.new
      status = tag.create_tags(tags,outfit_id)
      render json: {status: status, data: nil}
    end
  end

  def search_tags

  end
end
