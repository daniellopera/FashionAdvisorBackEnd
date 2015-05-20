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
  has_and_belongs_to_many :outfits, :class_name => "Outfit", join_table: "outfits_users", foreign_key:  "user_id",
                          association_foreign_key: "outfit_id"
  has_many :comments
  has_many :ratings
  has_many :activities

  # @param [Integer] product_id, this is the ID of the product we are looking for in the wardrobe
  # @return [Boolean] True if the product is in the users wardrobe.
  def has_product_in_wardrobe? (product_id)
      products.any? { |element| element.id == product_id}
  end

  # Get all the users that the current user is following
  def get_following
    followings_array = []
    following.each do |following|
      user = User.find(following.id)
      following_complete = {
      username: following.username,
      id: following.id,
      image: following.image,
      email: following.email,
      followers_number: user.followers.count,
      following_number: user.following.count
      }
      followings_array << following_complete
    end
    followings_array
  end

  # Get all the users that follow the current user
  def get_followers
    followers_array = []
    followers.each do |follower|
      user = User.find(follower.id)
      follower_complete = {
          username: follower.username,
          id: follower.id,
          image: follower.image,
          email: follower.email,
          followers_number: user.followers.count,
          following_number: user.following.count
      }
      followers_array << follower_complete
    end
    followers_array
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
    users = User.where("username LIKE ?", "%#{search_text}%").select('id', 'username', 'email', 'image')
    array = []
    users.map do |user|
      if following.include?(user)
        following = true
      else
        following = false
      end
      user = User.find(user['id'])

      u = {
            id: user['id'],
            username: user['username'],
            email: user['email'],
            image: user['image'],
            following_number:user.following.count,
            followers_number:user.followers.count,
            is_following: following
          }
      array << u if user.id != current_user.id
    end
    array
  end





end
