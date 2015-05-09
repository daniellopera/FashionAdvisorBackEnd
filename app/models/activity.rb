class Activity < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user

  def self.bring_following_activities(following_list)
    activities = []
    following_list.each do |following|
      user = User.find(following.id)
      feeds = user.activities
      feeds.each do |feed|
        activity = Activity.find(feed.id)
        activities << activity
      end
    end

    activities.sort_by(&:created_at).reverse
  end
end
