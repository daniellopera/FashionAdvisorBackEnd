require 'rails_helper'

RSpec.describe Rating, type: :model do

  it "should belong to an outfit" do
    should belong_to(:outfit)
  end

  it "should belong to a user" do
    should belong_to(:user)
  end

  it "should validate uniqueness of a rating made by a user." do
    should validate_uniqueness_of(:outfit_id).scoped_to(:user_id)
  end

  it "should validates presence of a user id" do
    should validate_presence_of(:outfit_id)
  end

  it "should add a new like to the outfit" do
    outfit = Outfit.create(id: 5, likes: 0, dislikes: 0)

    user = User.create(id: 10, username: "nicolas", email: "pera@pera.com")

    rating = Rating.create(outfit_id: outfit.id, user_id: user.id)
    result = rating.new_likes(outfit.id, 1)

    expect(result["likes"]).to eq(1)
  end

  it "should add a new dislike to the outfit" do
    outfit = Outfit.create(id: 5, likes: 0, dislikes: 0)

    user = User.create(id: 10, username: "nicolas", email: "pera@pera.com")

    rating = Rating.create(outfit_id: outfit.id, user_id: user.id)
    result = rating.new_likes(outfit.id, 0)

    expect(result["dislikes"]).to eq(1)
  end


end
