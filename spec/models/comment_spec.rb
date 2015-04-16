require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it "saves when user add outfit_id and comment" do
    lindeman = Comment.create!(outfit_id: 1, comment: "Lindeman")

    expect(lindeman.comment).to eq("Lindeman")

  end

  it "is invalid without comment" do

    #comment = Comment.create!(outfit_id:1)
    expect {Comment.create!(outfit_id:1)}.to  raise_error
  end

  it "is invalid with empty comment" do


    expect {Comment.create!(comment:"",outfit_id:1)}.to  raise_error

  end

  it "is invalid without  outfit_id" do


    expect {Comment.create!(comment:"Something")}.to  raise_error

  end


end
