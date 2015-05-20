class Tag < ActiveRecord::Base
  has_and_belongs_to_many :outfits
  validates_uniqueness_of :tag


end
