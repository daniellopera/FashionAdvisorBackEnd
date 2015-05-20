require 'shopsense'

class ProductsController < ApplicationController
  include ShopStyleApiHelper
  include HashFormatterHelper
  before_action :authenticate_user!


  # GET '/search/?search_text="XXX"&color_id=X&brand_id=X'
  # This method uses the Shopsense API to search products in their DB by their name, and renders the products in JSON format
  def search
    @products = []
    search_text = params[:search_text]
    brand_id = params[:brand_id]
    color_id = params[:color_id]
    raw_products = search_product_by_params(search_text, color_id, brand_id)
    unless raw_products == nil
      products = raw_products["products"]
      format_products_hash(products, current_user)
    end

    render json: { status: 0, data: {products: products} }
  end

  #GET /search/:id
  def search_product_by_id
    product = search_by_id(params[:id])
    render json: {status: 0, data:product}
  end

  # GET '/colors/' to list all the colors.
  # This is planned to be moved to a new "Search" controller.
  def list_colors
    colors_raw = search_colors_shopstyle
    colors =  formats_colors_hash(colors_raw)
    render json: { status: 0, data: {colors: colors} }
  end








end

