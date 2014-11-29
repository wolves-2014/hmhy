require 'rails_helper'

describe Assessment do
  it {should have_many(:indications)}
  it {should have_many(:feelings)}
  it {should have_many(:competencies)}
  it {should have_many(:providers)}
  it {should validate_presence_of(:word)}
  it {should validate_uniqueness_of(:word)}
end

