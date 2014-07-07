require 'rails_helper'

describe 'posts' do

	it 'starts with no posts' do
		visit '/posts'
		expect(page).to have_content 'No posts'
	end

end

describe 'content' do

	it 'adds the post to the homepage' do
		visit '/posts'
		click_link 'Create post'
		fill_in 'Title', with: 'New post'
		fill_in 'Description', with: 'Lorem ipsum'
		attach_file 'Picture', Rails.root.join('spec/images/Junyuan and Sasha.jpg')
		click_button 'Post'

		expect(current_path).to eq posts_path
		expect(page).to have_content 'New post'
		expect(page).not_to have_content 'No posts'
		expect(page).to have_css 'img.uploaded-pic'
	end

	before do
		Post.create(title: "Is post", description: "Three-headed monkey")
	end

	specify 'are listed on the homepage' do
		visit '/posts'
		expect(page).to have_content('Three-headed monkey')
	end
end
