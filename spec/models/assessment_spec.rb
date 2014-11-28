require 'rails_helper'

describe Assessment do
  it {should have_many(:indications)}
  it {should have_many(:feelings)}
  it {should have_many(:competencies)}
  it {should have_many(:providers)}
  it {should validate_presence_of(:word)}
  it {should validate_uniqueness_of(:word)}

  describe ".determine_prevalent" do
    before do
      @happy = Feeling.create!(word: "happy")
      @sad = Feeling.create!(word: "sad")
      @feels = [@sad]
      @vg_add = @happy.assessments.create!(word: "VG_addiction")
      @depression = @sad.assessments.create!(word: "depression")
    end

    it "should return depression for sad" do
      expect(Assessment.determine_prevalent(@feels).first).to be(@depression)
    end

    it "should return VG_addiction for happy and sad" do
      @feels << @happy
      @sad.indications.create!(assessment: @vg_add)
      expect(Assessment.determine_prevalent(@feels).first).to eq(@vg_add)
    end
  end
end

