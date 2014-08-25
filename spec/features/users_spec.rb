require 'spec_helper'

feature 'user authentication' do
  scenario 'users can register and logout' do
    visit '/'

    expect(page).to_not have_link 'logout'
    click_link 'register'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Register'

    expect(page).to have_content 'welcome, test@example.com'
    expect(page).to_not have_link 'register'

    # user gets a new registration email
    email_body = ActionMailer::Base.deliveries.last.body.raw_source
    expect(email_body).to include('Thank you for signing up!')

    # user logs out
    click_link 'logout'

    expect(page).to have_no_content 'welcome, test@example.com'
    expect(page).to have_content 'you have successfully logged out'
  end

  scenario 'users can login' do
    user = User.create!(email: 'test@example.com', password: 'password')
    visit '/'

    click_link 'login'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content 'welcome, test@example.com'
    expect(page).to have_content 'you have successfully logged in'
    expect(page).to have_content 'Profile'
    expect(page).to_not have_link 'login'
  end

  scenario 'users cannot register with invalid credentials' do
    visit '/'

    click_link 'register'

    fill_in 'Email', with: 'invalid.example,com'
    fill_in 'Password', with: '123'
    click_button 'Register'

    expect(page).to have_content 'Email is invalid'
    expect(page).to have_content 'Password is too short'
  end

  scenario 'users cannot login without registering first' do
    visit '/'

    click_link 'login'

    fill_in 'Email', with: "#{rand(1000)}@example.com"
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content 'invalid email or password'
  end

  scenario 'users cannot login with an invalid password' do
    user = User.create!(email: 'text@example.com', password: 'password')

    visit '/'

    click_link 'login'

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '38472983472'
    click_button 'Login'

    expect(page).to have_content 'invalid email or password'
  end
end