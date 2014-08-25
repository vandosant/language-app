require 'spec_helper'

describe UserMailer do
  it "sends new registration email" do
    user = User.new(email: 'user@example.com', password: 'Password1')
    email = UserMailer.new_registration(user).deliver
    expect(email.from).to eq ['info@langua.herokuapp.com']
    expect(email.to).to eq ['user@example.com']
    expect(email.subject).to eq 'Welcome to Langua'
    expect(email.body).to have_content 'Thank you for signing up!'
  end
end