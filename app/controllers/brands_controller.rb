class BrandsController < ApplicationController

  include ShopStyleApiHelper
  include HashFormatterHelper
  before_action :authenticate_user!


  # Updates the fashion advisor database brands with the Shopstyle database new brands.
  def update_brands
    brands_raw = search_brands_shopstyle
    brands = format_brands_hash(brands_raw["brands"])

    render json: {status: 0, data: {brands: brands}}
  end

  # List all the brands stored in the fashion advisor database.
  def list_brands
    brands = Brand.get_all_brands
    render json: {status: 0, data: {brands: brands}}
  end

  # List the most relevant brands according to the input given.
  def autocomplete_brands()
    brands = Brand.search_brands(params['search_param'])
    render json: {status: 0, data: {brands: brands}}
  end


end
