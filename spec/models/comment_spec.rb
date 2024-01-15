require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:first_user) { User.create(name: 'John') }

  context 'when updating comments counter' do
    let(:post) { Post.create(author: first_user, title: 'Hello', text: 'This is my first post') }

    it 'should update comments counter' do
      Comment.create(user: first_user, post:, text: 'This is a comment 1.')
      Comment.create(user: first_user, post:, text: 'This is a comment 2.')
      Comment.create(user: first_user, post:, text: 'This is a comment 3.')
      expect(post.comments_counter).to eq(3)
    end
  end
end
