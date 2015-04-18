require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it "is valid with a user_id, comment and outfit_id" do
    comment = Comment.new(user_id: 10,
                          comment: "This is a comment!",
                          outfit_id: 15
    )
    expect(comment).to be_valid
  end

  it "is invalid without an outfit_id" do
    comment = Comment.new(user_id: 10,
                          comment: "This is a comment!",

    )
    comment.valid?
    expect(comment.errors[:outfit_id]).to include("can't be blank")
  end

  it "is invalid without a comment" do
    comment = Comment.new(user_id: 10,
                          outfit_id: 15
    )
    comment.valid?
    expect(comment.errors[:comment]).to include("can't be blank")
  end

  it "is invalid without a user_id" do
    comment = Comment.new(comment: "This is a comment!",
                          outfit_id: 15
    )
    comment.valid?
    expect(comment.errors[:user_id]).to include("can't be blank")
  end

  it "should belong to an outfit" do
    should belong_to(:outfit)
  end

  it "should belong to a user" do
    should belong_to(:user)
  end

end
