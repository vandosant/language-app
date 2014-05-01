require 'spec_helper'

feature 'information' do
  scenario 'users can view details about the app' do
    visit '/'

    click_link 'about'

    expect(page).to have_content "About language-app"
    expect(page).to have_content "Created by: Scott Skender"
    expect(page).to have_link "home"
    expect(page).to have_link "login"
  end
end

feature 'users management' do
  scenario 'users can register, logout, and login' do
    visit '/'

    click_link 'register'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password'
    click_button 'register'

    expect(page).to have_content 'welcome, test@example.com'

    click_link 'logout'

    expect(page).to have_no_content 'welcome, test@example.com'

    click_link 'login'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password'
    click_button 'login'

    expect(page).to have_content 'welcome, test@example.com'
  end
end

feature 'vocabulary' do
  before do
    visit '/'

    click_link 'register'

    fill_in 'email', with: 'alltest@example.com'
    fill_in 'password', with: 'password'
    click_button 'register'
    click_link 'logout'
  end

  scenario 'users can view vocab for a language' do
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