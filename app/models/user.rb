class User < ActiveRecord::Base

  #This makes the User model the one that acts as th
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable


  has_and_belongs_to_many :products

  has_and_belongs_to_many :following, :class_name => "User", join_table: "followers_following", foreign_key:  "user_id",
                          association_foreign_key: "following_id"
  has_and_belongs_to_many :followers, :class_name => "User", join_table: "followers_following", foreign_key:  "following_id",
                          association_foreign_key: "user_id"
  has_many :outfits
  has_many :comments
  has_many :ratings
  has_many :activies

  # @param [Integer] product_id, this is the ID of the product we are looking for in the wardrobe
  # @return [Boolean] True if the product is in the users wardrobe.
  def has_product_in_wardrobe? (product_id)
      products.any? { |element| element.id == product_id}
  end

  # Get all the users that the current user is following
  def get_following
    following.select('id', 'email', 'username')
  end

  # Get all the users that follow the current user
  def get_followers
    followers.select('id', 'email', 'username')
  end

  # Adds a user to the following collection
  # @param [String] the id of the user that the current user will follow.
  # @return [Boolean] true if the user was added to the following list
  def follow_a_user(user_id)
    user = User.find_by_id(user_id)
    result = false
      if(following.find_by_id(user_id) == nil && User.find_by_id(user_id) != nil && user_id.to_i != id)
        following << user
        result = true
      end
    result
  end

  # @param [String] search_text, the search input
  # @param [User]
  # @return [Array] All the related users to the search input
  def search_users(search_text, current_user)
    users = User.where("username LIKE ?", "%#{search_text}%").select('id', 'username', 'email')
    array = []
    users.map do |user|
      if following.include?(user)
        following = true
      else
        following = false
      end
      u = {
            id: user['id'],
            username: user['username'],
            email: user['email'],
            following: following
          }
      array << u if user.id != current_user.id
    end
    array
  end





end
