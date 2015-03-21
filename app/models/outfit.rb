class Outfit < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :user

  def add_products_to_outfit(products_array)
    products_array.map do |p|
      product = Product.find(p.to_i)

      products << product
    end
  end
end
