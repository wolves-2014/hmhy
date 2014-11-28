require 'rails_helper'

describe Feeling do
  it {should have_many(:indications)}
  it {should have_many(:assessments)}
  it {should validate_presence_of(:word)}
  it {should validate_uniqueness_of(:word)}
end

