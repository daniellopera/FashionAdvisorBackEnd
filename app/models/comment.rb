class Comment < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user

  validates :outfit_id,
            presence: true

	validates :comment,
            presence: true



end
