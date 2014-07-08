require 'rails_helper'

describe 'posts' do

	it 'starts with no posts' do
		visit '/posts'
		expect(page).to have_content 'No posts'
	end

	# before do
		
	# end

	specify 'are listed on the homepage' do
		bob = User.create(email: "bob@bob.com", password: "12345678", password_confirmation: "12345678")
		bob.posts.create(title: "Is post", description: "Three-headed monkey")
		visit '/posts'
		expect(page).to have_content('Three-headed monkey')
	end

end

describe 'posts' do

	context 'when logged in' do

		before(:each) do
			bob = User.create(email: "bob@bob.com", password: "12345678", password_confirmation: "12345678")
			login_as bob
		end

		it 'allows user to post on the homepage' do
			visit "/posts/new"
			fill_in "Title", with: "sexy"
			fill_in "Description", with: "too sexy for my shirt"
			click_button "Post"
			expect(page).to have_content 'Posted by bob@bob.com'
			expect(page).to have_content 'too sexy for my shirt'
			expect(page).not_to have_content 'No posts'
			expect(current_path).to eq posts_path
			expect(page).not_to have_css 'img.uploaded-pic'
		end

	end

	context do

	end
end
