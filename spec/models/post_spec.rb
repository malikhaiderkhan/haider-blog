require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:first_user) { User.create(name: 'John') }

  subject(:posts) { Post.new(author: first_user, title: 'Hello', text: 'This is my first post') }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be less than or equal to 250' do
    subject.title = 'a' * 300
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be non negative integer' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid

    subject.comments_counter = 0
    expect(subject).to be_valid

    subject.comments_counter = 5
    expect(subject).to be_valid
  end

  it 'likes_counter should be non negative integer' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid

    subject.likes_counter = 0
    expect(subject).to be_valid

    subject.likes_counter = 5
    expect(subject).to be_valid
  end

  it 'should update posts counter' do
    subject.save
    comment1 = subject.comments.create(user: first_user, content: 'Comment 1')
    comment2 = subject.comments.create(user: first_user, content: 'Comment 2')

    subject.update_posts_counter
    subject.reload

    expect(subject.comments_counter).to eq(2)
    expect(subject.likes_counter).to eq(0)
  end

  it 'should return five recent comments' do
    subject.save
    comment1 = subject.comments.create(user: first_user, content: 'Comment 1')
    comment2 = subject.comments.create(user: first_user, content: 'Comment 2')
    comment3 = subject.comments.create(user: first_user, content: 'Comment 3')
    comment4 = subject.comments.create(user: first_user, content: 'Comment 4')
    comment5 = subject.comments.create(user: first_user, content: 'Comment 5')
    comment6 = subject.comments.create(user: first_user, content: 'Comment 6')

    recent_comments = subject.five_recent_comments

    expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
  end
end