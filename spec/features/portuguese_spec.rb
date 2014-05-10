require 'spec_helper'
require 'vcr'

feature 'vocabulary' do
  scenario 'users can view vocab', js: true do
    visit '/'

    click_link 'portuguese'

    click_link 'vocabulary'

    expect(page).to have_content "hello"
    expect(page).to have_content "olá"

    find("#next_button").click

    expect(page).to have_content "goodbye"
    expect(page).to have_content "adeus"
  end

  scenario 'users can translate individual words' do
    VCR.use_cassette('/portuguese/translate/hello') do
      visit '/'

      click_link 'portuguese'

      click_link 'translate'

      fill_in 'english', with: 'hello'
      click_button 'translate to portuguese'

      page.should have_css("input[value='hello']")
      expect(page).to have_content 'oi'
    end
  end

  scenario 'users get an error if translation is not found' do
    VCR.use_cassette('/portuguese/translate/how_are_you') do

      visit '/'

      click_link 'portuguese'

      click_link 'translate'

      expect(page).to have_no_content 'Sorry, no results.'

      fill_in 'english', with: 'how are you'
      click_button 'translate to portuguese'

      page.should have_css("input[value='how are you']")
      expect(page).to have_content 'Sorry, no results.'
    end
  end
end