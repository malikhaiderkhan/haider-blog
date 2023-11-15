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
end