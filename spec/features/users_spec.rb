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
  before 'users successfully register and logout' do
    visit '/'

    click_link 'register'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password'
    click_button 'register'

    expect(page).to have_content 'welcome, test@example.com'

    click_link 'logout'

    expect(page).to have_no_content 'welcome, test@example.com'
    expect(page).to have_content 'you have successfully logged out'
  end

  scenario 'users can login' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password'
    click_button 'login'

    expect(page).to have_content 'welcome, test@example.com'
    expect(page).to have_content 'you have successfully logged in'
  end

  scenario 'users see their profile page on login' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'password'
    click_button 'login'

    expect(page).to have_content 'welcome, test@example.com'
    expect(page).to have_content 'Profile'
  end

  scenario 'users cannot login with mismatched password' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: 'aaawerawa'
    click_button 'login'

    expect(page).to have_content 'error'
  end

  scenario 'users cannot login with mismatched email' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: 'laskfjekfjz@example.com'
    fill_in 'password', with: 'password'
    click_button 'login'

    expect(page).to have_content 'error'
  end
end