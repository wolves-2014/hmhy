require 'rails_helper'

describe Age do
  it {should have_many(:targets)}
  it {should have_many(:providers)}
  it {should validate_presence_of(:age_group)}
  it {should validate_uniqueness_of(:age_group)}
end

