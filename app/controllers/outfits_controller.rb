class OutfitsController < ApplicationController
  include ShopStyleApiHelper
  include HashFormatterHelper
  before_action :authenticate_user!

  def create

    unless params[:fullname].blank? && params[:products] == nil
      outfit = Outfit.new
      outfit.name = params[:fullname]
      outfit.description = params[:about]
      outfit.user_id = current_user.id
      if outfit.save
        outfit.add_products_to_outfit(params[:products])

        render json: {status: 0, data: {outfitid: outfit.id, outfit_products: outfit.products}}
      else
        render json: {status: 1, data: nil}
      end
    else
      render json: {status: 1, data: nil}
    end
  end



  def bring_outfits_from_wardrobe
    wardrobe_outfits = []
    current_user.outfits.order(:created_at => 'ASC').each do |outfit|
      complete_outfit = Hash.new
      products = outfit.products.select("id")
      rating = outfit.rating
      name = outfit.name
      description = outfit.description
      complete_outfit['name'] = name
      complete_outfit['description'] = description
      complete_outfit['products'] = format_products_in_outfit_hash(products)
      complete_outfit['rating'] = rating
      wardrobe_outfits << complete_outfit
    end
    render json: {status: 0, data: {wardrobe_outfits: wardrobe_outfits}}
  end

  def view_profile

  end
end

