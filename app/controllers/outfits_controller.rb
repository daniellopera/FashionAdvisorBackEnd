class OutfitsController < ApplicationController
  include ShopStyleApiHelper
  include HashFormatterHelper
  before_action :authenticate_user!


  def create
    unless params[:fullname].blank? && params[:products] == nil
      outfit = Outfit.new
      outfit.name = params[:fullname]
      outfit.likes = 0
      outfit.dislikes = 0
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

  #GET /user/outfits
  def bring_outfits_from_wardrobe
    wardrobe_outfits = []
    format_outfits_hash(wardrobe_outfits)
    render json: {status: 0, data: {wardrobe_outfits: wardrobe_outfits}}
  end


  #GET /user/outfits/:id/comments
  def get_outfit_comments
    if params[:id]
      outfit = Outfit.find_by_id(params[:id])


      comments = outfit.comments.select("comment", "user_id", "id", "created_at")
      comments_array = format_comments_hash(comments)
      #comments.user_id = User.find_by_id(comments.user_id).username

      render json: {status: 0, data: {outfit_comments: comments_array}}
    else
      render json:  {status: 1, data: nil}
    end

  end



  def get_outfit_by_name
    if params[:name]
      outfits = Outfit.new
      outfits = outfits.search_outfits_by_name(params[:name])
      render json: {status: 0, data: outfits}, except: [:created_at,:updated_at]
    else
      render json: {status: 1, data: nil}
    end

  end

  def get_oufit_by_id
    if params[:id]
        outfit  = Outfit.find_by_id(params[:id])

        if outfit
          render json: {status:0, data: outfit}, except: [:created_at,:updated_at]
        else
          render json: {status:1, data: nil}
        end
    else
      render json: {status:1, data: nil}
    end

  end


  # POST /outfits/recommend
  # { "products" : [id1, id2, id3, ... , idn]}
  def recommend_outfits_by_products
    if params[:products]
      outfits  = Outfit.recommend_outfits(params[:products])
      if outfits != nil
        render json: {status:0, data: outfits}, except: [:created_at,:updated_at]
      else
        render json: {status:1, data: outfits}
      end
    else
      render json: {status:1, data: nil}
    end

  end



end
