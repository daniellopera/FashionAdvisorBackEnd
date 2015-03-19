class OutfitsController < ApplicationController
  before_action :authenticate_user!

  def create

  end

  def bring_outfits_from_wardrobe
    wardrobe_outfits = []
    current_user.outfits.order(:created_at => 'ASC').each do |outfit|
      complete_outfit = Hash.new
      products =  outfit.products
      rating = outfit.rating
      name = outfit.name
      complete_outfit['name'] = name
      complete_outfit['products'] = products
      complete_outfit['rating'] = rating
      wardrobe_outfits << complete_outfit
    end
    render json: {status: 0, data:{wardrobe_outfits: wardrobe_outfits}}, except:[:created_at, :updated_at]
  end
end
