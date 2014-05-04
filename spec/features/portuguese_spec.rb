require 'spec_helper'

feature 'vocabulary' do
  scenario 'users can view vocab' do
    visit '/'

    click_link 'portuguese'

    click_link 'vocabulary'

    expect(page).to have_content "hello"
    expect(page).to have_content "alo"
  end

  scenario 'users can translate individual words' do
    visit '/'

    click_link 'portuguese'

    click_link 'translate'

    fill_in 'english', with: 'hello'
    click_button 'translate to portuguese'

    page.should have_css("input[value='hello']")
    expect(page).to have_content 'oi'
  end

  scenario 'users get an error if translation is not found' do
    visit '/'

    click_link 'portuguese'

    click_link 'translate'

    fill_in 'english', with: 'how are you'
    click_button 'translate to portuguese'

    page.should have_css("input[value='how are you']")
    expect(page).to have_content 'Sorry, no results.'
  end
end