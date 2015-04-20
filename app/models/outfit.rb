class Outfit < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :user
  has_many :ratings
  has_many :comments

  attr_accessor :num_comments

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
    related_outfits = search_outfits_by_products(products_array)
    related_outfits_relevance = get_outfits_relevance(related_outfits)
    ordered_relevance_array = order_outfits_by_relevance(related_outfits_relevance)
    puts ordered_relevance_array.inspect
    ordered_relevance_array
  end

  # Searches the outfits that contain any of the products given in the array.
  def self.search_outfits_by_products(products_array)
    outfits = []
    products_array.each do |id|
      outfits << Product.includes(:outfits).find(id).outfits
    end
  outfits
  end

  # Get the most relevant outfits, this means that the outfit that is contained the most
  # in the related_outfits variable will get the highest relevance.
  def self.get_outfits_relevance(related_outfits)
    most_related_outfits = []
    outfits_relevance = {}
    related_outfits.each do |outfits_array|
      outfits_array.each do |outfit|
        unless most_related_outfits.include? (outfit)
          most_related_outfits << outfit
          outfits_relevance[outfit.id] = 1
        else
          outfits_relevance[outfit.id] = outfits_relevance[outfit.id].to_i + 1
        end
      end
    end
    outfits_relevance
  end

  # Orders the outfits array using its relevance as a criteria.
  def self.order_outfits_by_relevance(relevance)
    relevance = relevance.sort_by {|k, v| v}.reverse
    ordered_outfits = []
    i = 0
    relevance.each do |r|
      ordered_outfits[i] = Outfit.find_by_id(r[0])
      i = i+1
    end
    ordered_outfits ##= Outfit.where(id: ordered_outfits)
  end

  def num_comments
    comments.size
  end

  def attributes
    super.merge('num_comments' => self.num_comments)
  end

end
