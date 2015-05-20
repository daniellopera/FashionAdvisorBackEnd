class FashionUpdatesController < ApplicationController

  before_action :authenticate_user!


  def bring_fashion_updates
    updates = FashionUpdate.get_fashion_updates
    render json: {status: 0, data: updates}
  end
end
