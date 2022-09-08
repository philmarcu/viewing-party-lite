require 'rails_helper'

RSpec.describe 'Admin Dashboard User index page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: "pwd")
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com', password: "pwd")
    @admin = User.create!(name: 'Ady the Admin', email: 'admin@viewingparty.com', password: 'admin', role: 2)

    login(@admin)
    visit admin_dashboard_path
  end

  def login(user)
    visit root_path
    click_on "Log In"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password
    click_on "Log In"
  end

  it 'title of application, links to existing user, button to create a new user' do
    expect(page).to have_content('Viewing Party Lite')
    expect(page).to have_link('jimb@viewingparty.com')
    expect(page).to have_link('caryb@viewingparty.com')
    expect(page).to have_link('Home')
    expect(page).to_not have_link('Tyler')
  end

  it 'has an index of existing users' do

    within "#user-#{@user1.id}" do
      expect(page).to have_link('jimb@viewingparty.com')
      # click_link('jimb@viewingparty.com')

      # expect(current_path).to eq(user_path(@user1.id))
    end
    # expect(page).to have_content("Jim Bob's Dashboard")

    visit admin_dashboard_path

    within "#user-#{@user2.id}" do
      expect(page).to have_link('caryb@viewingparty.com')
      # click_link('caryb@viewingparty.com')

      # expect(current_path).to eq(user_path(@user2.id))
    end
    # expect(page).to have_content("Cary Berry's Dashboard")

  end
end