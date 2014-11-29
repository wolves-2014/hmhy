require 'rails_helper'

describe Indication do
  before do
    @feeling = Feeling.create!(word: "blah")
    @assessment = Assessment.create!(word: "depression")
    @indication = Indication.create!(feeling: @feeling, assessment: @assessment)
  end

  it {should belong_to(:feeling)}
  it {should belong_to(:assessment)}
  it {should validate_presence_of(:feeling)}
  it {should validate_presence_of(:assessment)}
  it {should validate_uniqueness_of(:feeling).scoped_to(:assessment_id)}

  describe ".assess" do
    before do
      @happy = Feeling.create!(word: "happy")
      @sad = Feeling.create!(word: "wok")
      @feels = [@sad]
      @vg_add = @happy.assessments.create!(word: "VG_addiction")
      @depression = @sad.assessments.create!(word: "too happy")
    end

    it "should return depression for sad" do
      expect(Indication.assess(@feels).first).to be(@depression)
    end

    it "should return VG_addiction for happy and sad" do
      @feels << @happy
      @sad.indications.create!(assessment: @vg_add)
      expect(Indication.assess(@feels).first).to eq(@vg_add)
    end
  end

end

