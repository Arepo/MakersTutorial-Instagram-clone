require 'rails_helper'

describe 'liking posts' do 

	before do
		bob = User.create(email: "bob@bob.com", password: "12345678", password_confirmation: "12345678")
		bob.posts.create(title: "Is post", description: "Three-headed monkey")
	end

	it 'is initially at 0 likes' do
		visit '/posts'
		expect(page).to have_content '♥ 0'
	end

	it 'increments the like count of a post' do
		visit '/posts'
		click_link '♥ 0'
		expect(page).to have_content '♥ 1'
	end
end