require 'rails_helper'

RSpec.describe User, :type => :model do

  it "should have many comments" do
    should have_many(:comments)
  end

  it "should have many ratings" do
    should have_many(:ratings)
  end

  it "should have many outfits" do
    should have_many(:outfits)
  end

  it "should have and belong to many products" do
    should have_and_belong_to_many(:products)
  end

  it "should have and belong to many following" do
    should have_and_belong_to_many(:following)
  end

  it "should have and belong to many followers" do
    should have_and_belong_to_many(:followers)
  end

  it "should return true if the product is in the users wardrobe" do

    product = Product.new
    product.id = 100

    product.save

    user = User.new
    user.id = 10
    user.username = "nicolas"
    user.email = "n@a.com"
    user.products << product

    user.save

    result = user.has_product_in_wardrobe?(100)

    expect(result).to eq(true)
  end

  it "should return false if the product is not in the users wardrobe" do

    user = User.new
    user.id = 10
    user.username = "nicolas"
    user.email = "n@a.com"

    user.save

    result = user.has_product_in_wardrobe?(100)

    expect(result).to eq(false)
  end


  it "should return the amount of users following the main user" do
    user2 = User.new
    user2.id = 100
    user2.username = "pera"
    user2.email = "pene@a.com"

    user2.save

    user = User.new
    user.id = 10
    user.username = "nicolas"
    user.email = "n@a.com"
    user.following << user2

    user.save

    expect(user.following.size).to eq(1)
  end

  it "should return the info of users following the main user" do
    user2 = User.new
    user2.id = 100
    user2.username = "pera"
    user2.email = "pera@a.com"

    user2.save

    user = User.new
    user.id = 10
    user.username = "nicolas"
    user.email = "n@a.com"
    user.following << user2

    user.save

    expect(user.following[0].attributes).to include("username" => "pera", "id" => 100, "email" => "pera@a.com")
  end
end
