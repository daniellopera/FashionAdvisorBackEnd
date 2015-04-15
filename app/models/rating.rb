class Rating < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user

  def calculate_rating_average(outfit_id, new_rating)
    outfit  = Outfit.find(outfit_id)
    total_voters = outfit.ratings.all.count
    if outfit.rating == nil
      outfit.rating = 0
    end
    average_rate = ((outfit.rating*(total_voters-1) + new_rating)/total_voters).to_f
    outfit.rating = average_rate
    outfit.save
    average_rate
  end
end
