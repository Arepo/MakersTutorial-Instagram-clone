require 'rails_helper'

describe 'admins' do 

	xit 'cannot sign up' do
		visit 'admins/sign_up'
		expect(page).not_to have_content 'Sign up'
	end
	
end