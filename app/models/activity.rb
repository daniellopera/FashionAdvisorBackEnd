class Activity < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :user
end
