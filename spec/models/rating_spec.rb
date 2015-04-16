require 'rails_helper'

RSpec.describe Rating, type: :model do

  it " did't save when user don't  add outfit_id" do

    expect {Rating.create!(rating:5)}.to  raise_error

  end

end
