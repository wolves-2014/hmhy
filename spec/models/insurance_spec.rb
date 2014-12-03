require 'rails_helper'

describe Insurance do
  it {should have_many(:networks)}
  it {should have_many(:providers)}
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name)}
end

