class Rating < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user

  validates :outfit_id,
            presence: true
  validates_uniqueness_of :outfit_id, :scope => :user_id


  def new_likes(outfit_id, new_rating)
    outfit  = Outfit.find(outfit_id)
    answer = Hash.new
    if new_rating.to_i == 1
      outfit.likes += 1
    else
      outfit.dislikes += 1
    end
    answer['likes'] = outfit.likes
    answer['dislikes'] = outfit.dislikes
    if outfit.save
      answer['status'] = 0
    else
      answer['status'] = 1
    end
    answer
  end



  def update_likes(outfit_id, new_rating, user_id)
    answer = Hash.new
    #initialize outfit and rating objects
    outfit  = Outfit.find(outfit_id)
    rating = Rating.find_by(outfit_id: outfit_id, user_id: user_id)
    #initialize old rating and new rating variables
    old_rating = rating.rating
    new_rating = new_rating.to_i
    #save the new rating
    rating.rating = new_rating
    rating.save
    if new_rating == 1 && old_rating == 0
      outfit.dislikes += -1
      outfit.likes += 1
    elsif new_rating == 0 && old_rating == 1
      outfit.likes += -1
      outfit.dislikes += 1
    end
    answer['likes'] = outfit.likes
    answer['dislikes'] = outfit.dislikes
    if outfit.save
      answer['status'] = 0
    else
      answer['status'] = 1
    end
    answer
  end

end
