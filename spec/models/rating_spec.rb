require 'rails_helper'

RSpec.describe Rating, type: :model do

  it "did't save when user don't  add outfit_id" do

    expect {Rating.create!(rating:5)}.to  raise_error

  end

  it "saves when user enter rating and the outfit_id" do

    rating = Rating.create!(outfit_id:1,rating:5)

    expect(rating.rating).to eq(5)

  end

  it "did't save when user don't  add a rating" do

    expect {Rating.create!(outfit_id:1)}.to  raise_error

  end

end
