require 'spec_helper'

describe 'tags' do 

	context 'When logged in' do
		before do
			bob = User.create(email: 'Sasharita@a.com', password: '12345678', password_confirmation: '12345678')
			login_as bob
		end

		it 'adds posts to the homepage' do
			visit '/posts/new'
			fill_in 'Title', with: "test"
			fill_in 'Description', with: "kitteh"
			fill_in 'Tags', with: 'kitten, juggling'
			attach_file 'Picture', Rails.root.join('spec/images/Junyuan and Sasha.jpg')
			click_button "Post"
			expect(page).to have_link("kitten")
			expect(page).to have_link("juggling")
		end
	end
	
end