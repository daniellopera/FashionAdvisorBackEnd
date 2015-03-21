class Brand < ActiveRecord::Base

  # Method override this is to only create a brand if it doesn't exist already in the database
  # this handles authentication errors.
  def self.create(brand)
    # Only create the product if the brand doesn't exist.
    unless Brand.exists?(brand[:id])
      super(brand)
    end
  end
end
