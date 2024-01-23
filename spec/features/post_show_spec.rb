require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  let(:user) { User.create(name: 'Test User', photo: 'example.jpg') }
  let!(:post) { Post.create(author_id: user.id, title: 'Test Post', text: 'This is the body of the post.') }
  let!(:comment1) { Comment.create(user:, post:, text: 'Test Comment 1') }
  let!(:comment2) { Comment.create(user:, post:, text: 'Test Comment 2') }

  scenario 'I can see a post title' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.title)
  end

  scenario 'I can see who wrote the post' do
    visit user_post_path(user, post)
    expect(page).to have_content(user.name)
  end

  scenario 'I can see how many comments a post has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  scenario 'I can see how many likes a post has' do
    post.likes.create(user:)
    post.likes.create(user:)
    visit user_post_path(user, post)
    expect(page).to have_content("Likes: #{post.likes.count}")
  end

  scenario 'I can see the post body' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.text)
  end

  scenario 'I can see the username of each commenter' do
    visit user_post_path(user, post)
    expect(page).to have_content(comment1.user.name)
    expect(page).to have_content(comment2.user.name)
  end

  scenario 'I can see the comment each commenter left' do
    visit user_post_path(user, post)
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end
end