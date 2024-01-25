require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let!(:user) { User.create(name: 'Test User', bio: 'This is a test bio', photo: 'example.jpg') }
  let!(:posts) do
    (1..5).map do |i|
      user.posts.create(title: "Post #{i}", text: "Text #{i}")
    end
  end

  scenario 'I can see the user\'s profile picture' do
    visit user_path(user)
    expect(find('img')['src']).to include(user.photo)
  end

  scenario 'I can see the user\'s username' do
    visit user_path(user)
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    user = User.create(name: 'User', posts_counter: 3)

    visit user_path(user)

    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  scenario 'I can see the user\'s bio' do
    visit user_path(user)
    expect(page).to have_content(user.bio)
  end

  scenario 'I can see the user\'s first 3 posts' do
    visit user_path(user)
    user.three_recent_posts.each_with_index do |post, _index|
      expect(page).to have_content(post.title)
    end
  end

  scenario 'I can see a button that lets me view all of a user\'s posts' do
    visit user_path(user)
    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(user)
    post = user.three_recent_posts.first
    click_link post.title
    expect(current_path).to eq(user_post_path(user, post))
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(user)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(user))
  end
end