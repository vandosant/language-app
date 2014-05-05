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

feature 'user authentication' do
  before 'users can register and logout' do
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
    expect(page).to have_content 'Profile'
  end

  scenario 'users cannot register with invalid credentials' do
    visit '/'

    click_link 'register'

    fill_in 'email', with: 'invalid.example,com'
    fill_in 'password', with: '123'
    click_button 'register'

    expect(page).to have_content 'invalid email address'
    expect(page).to have_content 'password is too short'
  end

  scenario 'users cannot login without registering first' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: "#{rand(1000)}@example.com"
    fill_in 'password', with: 'password'
    click_button 'login'

    expect(page).to have_content 'invalid email or password'
  end

  scenario 'users cannot login with an invalid password' do
    visit '/'

    click_link 'login'

    fill_in 'email', with: 'test@example.com'
    fill_in 'password', with: '38472983472'
    click_button 'login'

    expect(page).to have_content 'invalid email or password'
  end
end