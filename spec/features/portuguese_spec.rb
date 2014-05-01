require 'spec_helper'

feature 'vocabulary' do
  before do
    visit '/'

    click_link 'register'

    fill_in 'email', with: 'alltest@example.com'
    fill_in 'password', with: 'password'
    click_button 'register'
    click_link 'logout'
  end

  scenario 'users can view vocab' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: 'alltest@example.com'
    fill_in 'password', with: 'password'
    click_button 'login'

    click_link 'portuguese'

    click_link 'vocabulary'

    expect(page).to have_content "hello"
    expect(page).to have_content "alo"
  end
end