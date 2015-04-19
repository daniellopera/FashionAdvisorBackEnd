class Outfit < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :user
  has_many :ratings
  has_many :comments

  def add_products_to_outfit(products_array)
    products_array.map do |p|
      product = Product.find(p.to_i)
      products << product
    end
  end

  def search_outfits_by_name(outfit_name)
    outfits = Outfit.where("name LIKE ?", "%#{outfit_name}%")
  end

  # This method will recommends the most relevant outfits that match the products id
  # list given.
  def self.recommend_outfits(products_array)
    related_outfits = get_related_outfits(products_array)
  end


  def self.get_related_outfits(products_array)
    related_outfits = []
    products_array.each do |id|
      related_outfits << Product.includes(:outfits).find(id).outfits
    end
    get_most_related_outfits(related_outfits)
  end

  def self.get_most_related_outfits(related_outfits)
    most_related_outfits = []
    most_related_outfits_ranking = {}
    related_outfits.each do |outfits_array|
      outfits_array.each do |outfit|
        unless most_related_outfits.include? (outfit)
          most_related_outfits << outfit
          most_related_outfits_ranking[outfit.id] = 1
        else
          most_related_outfits_ranking[outfit.id] = most_related_outfits_ranking[outfit.id].to_i + 1
        end
      end
    end
    most_related_outfits_ranking
  end


end
