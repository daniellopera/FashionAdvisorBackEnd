require 'rails_helper'

RSpec.describe User, :type => :model do

  it "should belong to an outfit" do
    should belong_to(:outfit)
  end

  it "should have many outfits" do
    should have_many(:outfits)
  end

end
