require 'rails_helper'

RSpec.describe User, :type => :model do

  it "saves when entered a valid email" do
    lindeman = User.create!(email: "andy@pene.com", password: "Lindeman")

    expect(lindeman.email).to eq("andy@pene.com")
  end

end
