require 'rails_helper'

describe Target do
  it {should belong_to(:age)}
  it {should belong_to(:provider)}
  it {should validate_presence_of(:age)}
  it {should validate_uniqueness_of(:provider)}
  #must have database populated or validation fails
end

