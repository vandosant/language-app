require 'spec_helper'
require 'vcr'

feature 'vocabulary' do
  scenario 'users can view vocab in multiple categories', js: true do
    visit '/'

    within('nav') do
      click_link 'portuguese'
    end

    click_link 'vocabulary'

    expect(page).to have_content "hello"
    expect(page).to have_content "olá"


    find("#next_button").click

    expect(page).to have_content "good morning"
    expect(page).to have_content "bom dia"


    find("#last_button").click

    expect(page).to have_content "hello"
    expect(page).to have_content "olá"

    find("#last_button").click

    expect(page).to have_content "good afternoon"
    expect(page).to have_content "boa tarde"

    find("[data-id='numbers']").click

    expect(page).to have_content "um"

    find("#last_button").click

    expect(page).to have_content "mil"
  end

  scenario 'users can translate individual words' do
    VCR.use_cassette('/portuguese/translate/hello') do
      visit '/'

      within('nav') do
        click_link 'portuguese'
      end

      click_link 'translate'

      fill_in 'english', with: 'hello'
      click_button 'translate to portuguese'

      page.should have_css("input[value='hello']")
      expect(page).to have_content 'oi'
      expect(page).to have_content 'olá'
      expect(page).to have_content 'Oh, olá outra vez'
    end
  end

  scenario 'users get an error if translation is not found' do
    VCR.use_cassette('/portuguese/translate/how_are_you') do

      visit '/'

      within('nav') do
        click_link 'portuguese'
      end

      click_link 'translate'

      expect(page).to have_no_content 'Sorry, no results.'

      fill_in 'english', with: 'how are you'
      click_button 'translate to portuguese'

      page.should have_css("input[value='how are you']")
      expect(page).to have_content 'Sorry, no results.'
    end
  end

  scenario 'logged in users can add phrases to a personal phrasebook' do
    VCR.use_cassette('portuguese/translate/goodbye') do
      user = User.create!(email: 'user@example.com', password: 'password123')
      visit '/'

      click_link 'login'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Login'

      expect(page).to have_content 'Phrasebook'
      expect(page).to have_content 'No saved phrases.'

      within('nav') do
        click_link 'portuguese'
      end

      click_link 'translate'

      fill_in 'english', with: 'goodbye'
      click_button 'translate to portuguese'

      expect(page).to have_content 'adeus'

      find("[data-id='adeus']").click

      click_link 'profile'

      expect(page).to have_content 'adeus'
      expect(page).to have_content 'goodbye'
    end
  end
end