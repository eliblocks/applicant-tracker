require 'rails_helper'

def sign_up(name, email, employer = false)
  click_on 'Sign up'
  fill_in 'Name', with: name
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  check 'user_employer' if employer
  click_on 'Sign up'
end

def sign_in(email)
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  click_on 'Log in'
end

RSpec.describe 'applicant tracker', type: :system do
  it 'shows the right applicants and employers to the right type of user' do
    visit '/'

    sign_up('Jack', 'jack@example.com')
    expect(page).to have_content('Employers')
    click_on 'Log out'

    sign_up('Fountain', 'careers@fountain.com', true)
    expect(page).to have_content('Applicants')
    expect(page).not_to have_content('Jack')
    click_on 'Log out'

    sign_up('Algolia', 'careers@algolia.com', true)
    expect(page).not_to have_content 'Jack'
    click_on 'Log out'

    sign_in('jack@example.com')
    expect(page).to have_css('form', count: 2)
    click_on 'Algolia'
    expect(page).to have_content('Successfully applied to Algolia') #brittle!
    expect(page).to have_css('form', count: 1)
    click_on 'Log out'

    sign_in('careers@algolia.com')
    expect(page).to have_content 'Jack'
    click_on 'Log out'

    sign_in('career@fountain.com')
    expect(page).not_to have_content 'Jack'
  end
end
