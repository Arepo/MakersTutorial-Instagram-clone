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
			fill_in "Address", with: "25 City Road"
			click_button "Post"
			expect(page).to have_content 'Posted by bob@bob.com'
			expect(page).to have_content 'too sexy for my shirt'
			expect(page).not_to have_content 'No posts'
			expect(current_path).to eq posts_path
			expect(page).not_to have_css 'img.uploaded-pic'
		end

		it 'allows you to include a photo with your post' do
			visit "/posts/new"
			visit "/posts/new"
			fill_in "Title", with: "sexy"
			fill_in "Description", with: "too sexy for my shirt"
			attach_file 'Picture', Rails.root.join('spec/images/Junyuan and Sasha.jpg')
			click_button "Post"
			expect(page).to have_css 'img.uploaded-pic'
		end

	end

	context "when logged out" do

		it "will not create new posts" do
			visit '/posts'
			click_link "Create post"
			expect(page).to have_content 'Sign in'
			expect(page).not_to have_field 'Description'
		end

	end
end

describe 'filter posts by tag' do
	
		before do
			bob = User.create(email: "bob@bob.com", password: "12345678", password_confirmation: "12345678")
			bob.posts.create(title: 'Pic1', tag_names: 'yolo')
			bob.posts.create(title: 'Pic2', tag_names: 'swag')
			visit '/posts'
		end

	it 'only shows posts with the selected tag' do
		click_link '#yolo'
		expect(page).to have_css 'h1', text: 'Posts tagged with #yolo'
		expect(page).to have_content 'Pic1'
		expect(page).not_to have_content 'Pic2'
	end

	it 'uses the tag name in the url' do
		click_link '#yolo'
		expect(current_path).to eq '/tags/yolo'
	end
end
