module ShopStyleApiHelper

  API_KEY = 'uid9921-26902161-26'
  API_URI = 'http://api.shopstyle.com/api/v2'
  PARAM_PID = "pid="
  PARAM_LIMIT = "&limit=20"

  # Search a product by a given ID in the ShopStyle API.
  # @param [Integer] id The id of the product wanted to fetch.
  # @return [Hash] Hash of the product information.
  def search_by_id(id)
    product_by_id_param = "/products/#{id}?"
    p = JSON.parse(Net::HTTP.get(URI.parse(API_URI << product_by_id_param << PARAM_PID << API_KEY)))
  end

  # Search all the brands of the shopstyle database
  def search_brands_shopstyle
    brands_uri_param = "/brands?"
    p = JSON.parse(Net::HTTP.get(URI.parse(API_URI << brands_uri_param << PARAM_PID << API_KEY)))
  end

  # Search all the colors of the shopstyle database
  def search_colors_shopstyle
    colors_uri_param = "/colors?"
    p = JSON.parse(Net::HTTP.get(URI.parse(API_URI << colors_uri_param << PARAM_PID << API_KEY)))
  end

  # Search the products that match the given parameters.
  # @param [String] search_text, relevant words that could match in the name or description of the product.
  # @param [String] color_id, color of the products that want to search
  # @param [String] brand_id, brand of the products that want to search
  # @return [Hash] products returned by the shopstyle database.
  def search_product_by_params(search_text, color_id, brand_id)
    products_uri_param = "/products?"
    products_specific_params = ""

    unless search_text.blank?
      add_filter_to_products_uri(products_specific_params, 1, search_text)
    end

    unless color_id.blank?
      add_filter_to_products_uri(products_specific_params, 2, color_id)
    end

    unless brand_id.blank?
      add_filter_to_products_uri(products_specific_params, 3, brand_id)
    end
    p = ["products" => ""]
    unless search_text.blank? && brand_id.blank? && brand_id.blank?
      p = JSON.parse(Net::HTTP.get(URI.parse(API_URI << products_uri_param << PARAM_PID << API_KEY << products_specific_params)))
    end
  end

  # @param [String] uri, the uri that will be formatted.
  # @param [String] type, type of the filter that will be added.
  # @param [String] value, value of the parameter.
  # @return [String] the formatted uri.
  def add_filter_to_products_uri(uri, type, value)
    if type == 1
      uri = uri << '&fts=' << value
    elsif type == 2
      uri = uri << '&fl=c' << value
    elsif type == 3
      uri = uri << '&fl=b' << value
    end
      uri
  end



end
