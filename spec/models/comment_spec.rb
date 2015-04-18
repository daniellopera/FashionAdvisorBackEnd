require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it "saves a comment in the database" do
    comment = Comment.create!(outfit_id: 1, comment: "Lindeman", user_id: 10)

    expect(Comment.all.count).to eq(1)

  end

  it "saves a comment with the specific outfits id" do
    comment = Comment.create!(outfit_id: 1, comment: "Lindeman", user_id: 10)

    expect(comment.outfit_id).to eq(1)
  end

  it "saves a comment with the specific user id" do
    comment = Comment.create!(outfit_id: 1, comment: "Lindeman", user_id: 10)

    expect(comment.user_id).to eq(10)
  end

  it "saves a comment with the specific content" do
    comment = Comment.create!(outfit_id: 1, comment: "Lindeman", user_id: 10)

    expect(comment.comment).to eq("Lindeman")
  end

  it "is invalid without outfit_id" do

    expect {Comment.create!(comment:"Something")}.to  raise_error

  end

  it "is invalid without user_id" do

    expect {Comment.create!(outfit_id: 1, comment:"Something")}.to  raise_error

  end


end
