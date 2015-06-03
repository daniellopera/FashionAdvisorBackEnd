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

    brands = brands_hash.map do |p|
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

  def format_products_in_outfit_hash(products)

    final_products = products.map do |p|
      product = search_by_id(p['id'])
      product
    end
  end


  def format_outfits_hash(wardrobe_outfits)
    outfits = []
    wardrobe_outfits.each do |outfit|
      complete_outfit = Hash.new
      complete_outfit['id'] = outfit.id
      complete_outfit['name'] = outfit.name
      complete_outfit['description'] = outfit.description
      complete_outfit['products'] = outfit.products.select("id")
      complete_outfit['likes'] = outfit.likes
      complete_outfit['dislikes'] = outfit.dislikes
      complete_outfit['num_comments'] = outfit.num_comments
      complete_outfit['tags'] = outfit.tags
      complete_outfit['username'] = User.find_by_id(outfit.user_id).username
      outfits << complete_outfit
    end
    outfits
  end

  def format_ratings_hash(ratings, user_id)
    user = User.find(user_id)
    ratings_from_user = user.ratings.select('outfit_id', 'rating')
    ratings_from_user.each do |rate|
      rates = Hash.new
      rates['outfit_id'] = rate.outfit_id
      if rate.rating
        rates['rating'] = 1
      else
        rates['rating'] = 0
      end
      ratings << rates
    end
  end

  def format_comments_hash(comments)
    comments_array = []
    comments.each do
    |comment|
      comment_array = {}
      comment_array["comment"] = comment.comment
      comment_array["username"] = comment.user.username
      comment_array["date"] = comment.created_at
      comments_array << comment_array
    end
    comments_array
  end

  def format_activities_hash(activities)
    activities_array = []
    activities.each do |activity|
      feed = Hash.new
      feed['username'] = User.find_by_id(activity.user_id).username
      feed['image'] = User.find_by_id(activity.user_id).image
      feed['outfit_id'] = activity.outfit_id
      feed['outfit_name'] = Outfit.find_by_id(activity.outfit_id).name
      feed['feed_type'] = activity.feed_type
      feed['date'] = activity.created_at
      activities_array << feed
    end
    activities_array
  end

  def format_outfit_hash(outfit)
      complete_outfit = Hash.new
      user = User.find(outfit.user_id)
      complete_outfit['id'] = outfit.id
      complete_outfit['name'] = outfit.name
      complete_outfit['description'] = outfit.description
      complete_outfit['products'] = outfit.products.select("id")
      complete_outfit['likes'] = outfit.likes
      complete_outfit['dislikes'] = outfit.dislikes
      complete_outfit['num_comments'] = outfit.num_comments
      complete_outfit['username'] = user.username
      complete_outfit['tags'] = outfit.tags
      complete_outfit
  end

end