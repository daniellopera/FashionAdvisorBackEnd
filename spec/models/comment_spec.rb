require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it "saves a comment in the database" do
    comment = Comment.create!(outfit_id: 1, comment: "Lindeman")

    expect(Comment.all.count).to eq(1)

  end

  it "saves a comment with the specific outfits id" do


  end

  it "is invalid with empty comment" do


    expect {Comment.create!(comment:"",outfit_id:1)}.to  raise_error

  end

  it "is invalid without  outfit_id" do


    expect {Comment.create!(comment:"Something")}.to  raise_error

  end


end
