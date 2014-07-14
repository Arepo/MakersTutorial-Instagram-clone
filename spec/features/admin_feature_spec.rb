require 'rails_helper'

describe 'admins' do 

	it 'cannot sign up' do
		expect{visit 'admins/sign_up'}.to raise_error
	end
	
end