class UsersController < ApplicationController
  include ShopStyleApiHelper
  include HashFormatterHelper
  
  def search
    search_results = current_user.search_users(params[:user_name])
    if search_results.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: {users: search_results}}
    end
  end

  def following_users
    following_list = current_user.get_following
    if following_list.blank?
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: following_list}
    end
  end

  def followers_users
    followers_list = current_user.get_followers
    if followers_list == nil
      render json: {status: 1, data: nil}
    else
      render json: {status: 0, data: followers_list}
    end
  end

  def follow_a_user
    if current_user.follow_a_user(params[:user_id])
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

  # GET 'user/products'
  # Brings the current users wardrobe products and returns the array of products in a JSON format
  def get_products_from_wardrobe
    wardrobe_products = []
    current_user.products.order(:created_at => 'ASC').each do |product|
      wardrobe_products << search_by_id(product.id)
    end
    render json: {status: 0, data:{wardrobe_products: wardrobe_products}}
  end

  # POST 'user/products'
  # Adds a specific product to the current users wardrobe
  def add_product_to_wardrobe
    if current_user.products.find_by_id(params[:product_id]) == nil

      current_user.products << Product.find(params[:product_id])
      product = search_by_id(params[:product_id])

      render json: {status: 0, data: {product: product}}
    else

      render json: {status: 1, data: nil}
    end

  end


end
