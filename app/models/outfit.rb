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

end
