require 'rails_helper'

describe 'user visits visits home page' do
  it 'can navigate to new user page and create an account' do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')

    visit '/'
    click_on 'Login'
    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on 'Log In'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.address)
    expect(page).to have_link('Logout')
    expect(page).to_not have_content('Login')
  end

  it "and it redirects if invalid information is provided" do
    visit '/'
    click_on 'Login'

    fill_in :email, with: ''
    fill_in :password, with: ''
    click_on 'Log In'

    expect(current_path).to eq(login_path)
  end


  it 'user can logout and see a login link' do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')

    visit login_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_on 'Log In'

    click_on 'Logout'
    # save_and_open_page
    expect(current_path).to eq('/')
    expect(page).to_not have_link('Logout')
    expect(page).to have_content('Login')
  end
end
