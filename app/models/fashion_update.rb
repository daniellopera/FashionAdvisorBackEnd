class FashionUpdate < ActiveRecord::Base

  def self.get_fashion_updates
    updates = []
    FashionUpdate.all.each do |update|
      updates << update
    end
    updates
  end
end
