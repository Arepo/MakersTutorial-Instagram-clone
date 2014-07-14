require 'rails_helper'

describe 'registration' do

	it 'lets you sign up' do
		visit '/users/sign_up'
		click_button 'Sign up'
		
 		within('.new_user') do
			fill_in 'Email', with: "bobbity@bob.ob"
			fill_in "Password", with: '12345678'
			fill_in "Password confirmation", with: '12345678'
			click_button "Sign up"
		end
		expect(page).to have_content "signed up successfully"
		expect(current_path).to eq '/'
	end
end

describe 'logging in' do

	it 'lets you sign in' do
		User.create(email: "bobbity@bob.ob", password: '12345678', password_confirmation: '12345678')
		visit '/users/sign_in'
		within('.new_user') do
			fill_in 'Email', with: 'bobbity@bob.ob'
			fill_in 'Password', with: '12345678'
			click_button 'Sign in'
		end
		expect(page).to have_content "Signed in successfully"
		expect(current_path).to eq '/'
	end
	
end