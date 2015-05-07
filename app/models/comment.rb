class Comment < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user
  after_save :create_activity

  validates :outfit_id,
            presence: true

	validates :comment,
            presence: true

  validates :user_id,
            presence: true

  def create_activity
    activity = Activity.new
    activity.user_id = self.user_id
    activity.outfit_id = self.outfit_id
    activity.type = "commented"
    activity.save
  end



end
