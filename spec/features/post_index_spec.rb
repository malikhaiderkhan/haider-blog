require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  let(:user) { User.create(name: 'Test User', photo: 'example.jpg') }
  let!(:post) { Post.create(author_id: user.id, title: 'Test Post', text: 'This is the body of the post.') }

  scenario 'I can see the user\'s profile picture' do
    visit user_posts_path(user)
    expect(find('img')['src']).to include(user.photo)
  end

  scenario 'I can see the user\'s username' do
    visit user_posts_path(user)
    expect(page).to have_content(user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_posts_path(user)
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario 'I can see a post\'s title' do
    visit user_posts_path(user)
    expect(page).to have_content(post.title)
  end

  scenario 'I can see some of the post\'s body' do
    visit user_posts_path(user)
    expect(page).to have_content(post.text)
  end

  scenario 'I can see the first comments on a post' do
    comment = post.comments.create(user:, text: 'Test Comment')
    visit user_posts_path(user)
    expect(page).to have_content("#{comment.user.name}: #{comment.text}")
  end

  scenario 'I can see how many comments a post has' do
    post.comments.create(user:, text: 'Test Comment 1')
    post.comments.create(user:, text: 'Test Comment 2')
    visit user_posts_path(user)
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  scenario 'I can see how many likes a post has' do
    post.likes.create(user:)
    post.likes.create(user:)
    visit user_posts_path(user)
    expect(page).to have_content("Likes: #{post.likes.count}")
  end

  scenario 'I can see a section for pagination' do
    visit user_posts_path(user)
    expect(page).to have_link('Pagination', href: user_posts_path(user))
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    visit user_posts_path(user)
    click_link post.title
    expect(current_path).to eq(user_post_path(user, post))
  end
end
