module HashFormatterHelper

  # This method formats the hash that is returned from the ShopStyle API, adds a field
  # which tells if a product belongs to a users wardrobe.
  # @param [Hash] products_hash Raw Hash returned by the API
  # @return [Object] Returns the formatted hash with the proper keys and values.
  def format_products_hash(products_hash, user)
    @products = products_hash.map! do |p|
      p['in_wardrobe'] = false

      Product.create(p["id"].to_i)

      if user.has_product_in_wardrobe?(p['id'].to_i)
        p['in_wardrobe'] = true
      end
      p  #This is necessary to return the value
    end
  end

  # This method formats the hash that is returned from the ShopStyle API, will add
  # the brands that don't exist in the fashion advisor database already.
  # @param [Hash] brands_hash Raw Hash returned by the API
  # @return [Object] Returns the formatted hash with the proper keys and values.
  def format_brands_hash(brands_hash)

    brands = brands_hash.map! do |p|
      brand = {
          id: p['id'],
          name: p['name']
      }
      Brand.create(brand)
      brand
    end
  end

  # This method formats the hash that is returned from the ShopStyle API
  # @param [Hash] color_hash Raw Hash returned by the API
  # @return [Object] Returns the formatted hash with the proper keys and values
  def formats_colors_hash(colors_hash)
    colors_hash['colors']
  end
end