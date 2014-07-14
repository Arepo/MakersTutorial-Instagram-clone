require 'rails_helper'

describe 'orders page' do
	let(:post){Post.create title: 'Pretty picture'}
	let(:user){User.create email: 'customer@blah.com', password: '12345678', password_confirmation: '12345678'}
	let(:admin){Admin.create email: 't@t.com', password: '12345678', password_confirmation: '12345678'}

	context 'logged in as admin' do

		context 'with orders' do
			before do
				login_as admin, scope: :admin
				christmas_day = Date.new(2013,12,25)

				Order.create(id: 1, post: post, user: user, created_at: christmas_day)
				visit '/orders'
			end

			it 'displays the product' do
				expect(page).to have_link 'Pretty picture'
			end

			it 'displays the customer email' do
				expect(page).to have_content 'customer@blah.com'
			end

			it 'displays an order number' do
				expect(page).to have_content '2512130001'
			end
		end

		context 'no orders' do
			before do
				login_as admin, scope: :admin
			end

			it 'sees a message' do
				visit '/orders'
				expect(page).to have_content 'No orders yet'
			end
		end
	end

	context 'not logged in as admin' do
		it 'prompts to sign in' do
			visit '/orders'
			expect(page).to have_content 'Sign in'
		end
	end
end