require 'rails_helper'

describe Network do
  it {should belong_to(:insurance)}
  it {should belong_to(:provider)}
  it {should validate_presence_of(:insurance)}
  it {should validate_uniqueness_of(:provider)}
  #must have database populated or validation fails
end

