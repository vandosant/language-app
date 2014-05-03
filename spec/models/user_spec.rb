require 'spec_helper'

describe User do

  before { @user = User.new(email: 'test@example.com', password: 'password') }

  it 'allows querying for users' do
    expect(@user).to respond_to(:email)
    expect(@user).to respond_to(:password)
    expect(@user).to respond_to(:password_digest)
  end

  it 'requires email presence' do
    user = User.new(email: '', password: 'password')
    expect(user).to_not be_valid
  end

  it 'rejects invalid emails' do
    emails = ['foo@baz,com', 'foo_bar.org', 'foo@bar!baz.com']

    emails.each do |email|
      user = User.new(email: email, password: 'password')
      expect(user).to_not be_valid
    end
  end

  it 'accepts valid emails' do
    emails = ['foo@baz.com', 'foo@bar.ORG', 'foo-bar_baz@foo.com']

    emails.each do |email|
      user = User.new(email: email, password: 'password')
      expect(user).to be_valid
    end
  end

  it 'rejects duplicate emails' do
    another_user = @user.dup
    another_user.email = @user.email.upcase
    another_user.save
    expect(@user).to_not be_valid
  end

  it 'requires password presence' do
    user = User.new(email: 'test@example.com', password: '')
    expect(user).to_not be_valid
  end

  it 'allows user registration and authentication' do
    user = User.create(email: 'user@test.com', password: 'password')
    found_user = User.find_by_email(user.email)

    expect(found_user.authenticate(user.password)).to eq user
    expect(found_user.authenticate('invalid')).to eq false
  end

  it 'requires secure passwords' do
    user = User.new(email: 'user@test.com', password: '123')
    expect(user).to_not be_valid
  end
end