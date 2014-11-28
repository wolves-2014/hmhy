require 'rails_helper'

describe Location do

  it {should have_many(:residences)}
  it {should have_many(:providers)}
  it {should validate_uniqueness_of(:zip_code)}
  it {should validate_presence_of(:zip_code)}
  it {should validate_presence_of(:lat)}
  it {should validate_presence_of(:lng)}
end

