require 'rails_helper'

describe 'registration/login' do

	it 'lets you sign up' do
		visit '/users/sign_up'
		click_button 'Sign up'
		fill_in 'Email', with: "bobbity@bob.ob"
		fill_in "Password", with: '12345678'
		fill_in "Password confirmation", with: '12345678'
		click_button "Sign up"
		expect(page).to have_content "signed up successfully"
		expect(current_path).to eq '/'
	end



	it 'lets you sign in' do
		User.create(email: "bobbity@bob.ob", password: '12345678', password_confirmation: '12345678')
		visit '/users/sign_in'
		fill_in 'Email', with: 'bobbity@bob.ob'
		fill_in 'Password', with: '12345678'
		click_button 'Sign in'
		expect(page).to have_content "Signed in successfully"
		expect(current_path).to eq '/'
	end
	
end