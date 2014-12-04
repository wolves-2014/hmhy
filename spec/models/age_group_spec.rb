require 'rails_helper'

describe AgeGroup do
  it {should have_many(:targets)}
  it {should have_many(:providers)}
  it {should validate_presence_of(:generation)}
  it {should validate_uniqueness_of(:generation)}
end

