class User < ActiveRecord::Base

  #This makes the User model the one that acts as th
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable


  has_and_belongs_to_many :products
  has_many :outfits
  has_many :comments
  has_many :ratings
  has_and_belongs_to_many :following, :class_name => "User", join_table: "followers_following_join", foreign_key:  "user_id",
           association_foreign_key: "following_id"
  has_and_belongs_to_many :follower, :class_name => "User", join_table: "followers_following_join", foreign_key:  "following_id",
                          association_foreign_key: "user_id"



  # @param [Integer] product_id, this is the ID of the product we are looking for in the wardrobe
  # @return [Boolean] True if the product is in the users wardrobe.
  def has_product_in_wardrobe? (product_id)
      products.any? { |element| element.id == product_id}
  end

end
