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
end