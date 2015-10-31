require 'rails_helper'

RSpec.describe 'Select feelings', type: :feature do
  context 'as a visitor', js: true do
    scenario 'choose a feeling' do
      pending 'test setup required'
      primary_feeling = create :feeling
      secondary_feeling = create :feeling, :secondary
      tertiary_feeling = create :feeling, :tertiary

      visit '/'
      click_on primary_feeling.word
      expect(page).to have_text secondary_feeling.word
      click_on secondary_feeling.word
      expect(page).to have_text tertiary_feeling.word
    end
  end
end
