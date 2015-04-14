require 'rails_helper'

RSpec.describe Comment, :type => :model do

  it "saves when user add outfit_id and comment" do
    lindeman = Comment.create!(outfit_id: 1, comment: "Lindeman")

    expect(lindeman).to eq(lindeman)
  end

end
