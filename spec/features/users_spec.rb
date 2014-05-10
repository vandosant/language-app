require 'spec_helper'

feature 'information' do
  scenario 'users can view details about the app' do
    visit '/'

    click_link 'about'

    expect(page).to have_content "About langua"
    expect(page).to have_content "Created by: Scott Skender"
    expect(page).to have_link "home"
    expect(page).to have_link "languages"
  end
end

feature 'user authentication' do
  before 'users can register and logout' do
    pending
    visit '/'

    click_link 'register'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Register'

    expect(page).to have_content 'welcome, test@example.com'

    click_link 'logout'

    expect(page).to have_no_content 'welcome, test@example.com'
    expect(page).to have_content 'you have successfully logged out'
  end

  scenario 'users can login' do
    pending
    visit '/'

    click_link 'login'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content 'welcome, test@example.com'
    expect(page).to have_content 'you have successfully logged in'
    expect(page).to have_content 'Profile'
  end

  scenario 'users cannot register with invalid credentials' do
    pending
    visit '/'

    click_link 'register'

    fill_in 'Email', with: 'invalid.example,com'
    fill_in 'Password', with: '123'
    click_button 'Register'

    expect(page).to have_content 'invalid email address'
    expect(page).to have_content 'password is too short'
  end

  scenario 'users cannot login without registering first' do
    pending
    visit '/'

    click_link 'login'

    fill_in 'Email', with: "#{rand(1000)}@example.com"
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content 'invalid email or password'
  end

  scenario 'users cannot login with an invalid password' do
    pending
    visit '/'

    click_link 'login'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '38472983472'
    click_button 'Login'

    expect(page).to have_content 'invalid email or password'
  end
end