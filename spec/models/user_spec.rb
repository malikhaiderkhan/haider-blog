require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:users) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should be present' do
    user = User.create(photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    expect(user).to_not be_valid
  end

  it 'post_count should be non negative integer' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid

    subject.posts_counter = 0
    expect(subject).to be_valid

    subject.posts_counter = 5
    expect(subject).to be_valid

    subject.posts_counter = 'abc'
    expect(subject).to_not be_valid
  end

  it 'expect recent posts to be 0 ' do
    expect(subject.three_recent_posts.length).to eq(0)
  end
end
