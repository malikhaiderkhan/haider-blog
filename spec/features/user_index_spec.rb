require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  scenario 'I can see the username of all other users' do
    user1 = User.create(name: 'User1')
    user2 = User.create(name: 'User2')

    visit users_path

    expect(page).to have_content(user1.name)
    expect(page).to have_content(user2.name)
  end

  scenario 'I can see the profile picture for each user' do
    user = User.create(name: 'User', photo: 'example.jpg')

    visit users_path

    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    user = User.create(name: 'User', posts_counter: 3)

    visit users_path

    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    user = User.create(name: 'User')

    visit users_path
    click_link user.name

    expect(current_path).to eq(user_path(user))
  end
end