require 'rails_helper'

RSpec.describe User, :type => :model do

  it "saves when entered a valid email" do
    lindeman = User.create!(email: "andy@pene.com", password: "Lindeman")

    expect(lindeman.email).to eq("andy@pene.com")
  end


  it "did't saves when the user enter empty password" do
      expect {User.create!(email:"andy@pene.com")}.to  raise_error
  end

  it "did't saves when the user enter empty email" do
      expect {User.create!(password:"12345678")}.to  raise_error
  end
end
