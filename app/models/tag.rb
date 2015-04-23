class Tag < ActiveRecord::Base
  has_and_belongs_to_many :outfits
  validates_uniqueness_of :tag

  def create_tags(tags, outfit_id)
    outfit = Outfit.find(outfit_id)
    tags.each do |tag_user|
      tag = Tag.new
      tag.tag = tag_user
      tag.tag_counter = 0
      if tag.save
        outfit.tags << tag
        answer = 0
      elsif(Tag.find_by_tag(tag.tag) != nil)
        old_tag = Tag.find_by_tag(tag.tag)
        if outfit.tags.find_by_id(old_tag.id) == nil
          outfit.tags << old_tag
        end
        answer = 0
      else
        answer = 1
      end
      return answer
    end
  end
end
