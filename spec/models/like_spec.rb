require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:first_user) { User.create(name: 'John') }
  let(:second_user) { User.create(name: 'Jane') }

  context 'should update likes counter' do
    let(:post) { Post.create(author: first_user, title: 'Hello', text: 'This is my first post') }
    subject { Like.new(user: second_user, post:) }

    before { post.save }

    it 'should update likes counter' do
      Like.create(user: second_user, post:)
      Like.create(user: first_user, post:)
      Like.create(user: second_user, post:)
      expect(post.likes_counter).to eq(3)
    end
  end
end
