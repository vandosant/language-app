require 'spec_helper'

feature 'vocabulary' do
  scenario 'users can view vocab' do
    visit '/'

    click_link 'portuguese'

    click_link 'vocabulary'

    expect(page).to have_content "hello"
    expect(page).to have_content "alo"
  end
end