require 'rails_helper'

describe Post do 

	describe '#tag_names' do 
		let(:post) {Post.create}
		describe 'no tags' do
			
			
			it 'can have no tag names' do
				expect(post.tags).to be_empty
			end
		end

		describe 'one tag that doesnt exist' do

			it 'adds a tag to post' do
				post.tag_names = 'yolo'
				expect(post.tags.length).to eq 1
			end
		end

		describe 'multiple tags that don\'t already exist' do
			it 'adds two tags to post' do
				post.tag_names = 'raven, sailor'
				expect(post.tags.length).to eq 2
			end
		end

		describe 'tags that already exist' do
				let!(:tag) { Tag.create(name: 'ponies') }

			it 'reuses tags if they already exist' do
				post.tag_names = 'ponies'
				expect(Tag.count).to eq 1
				expect{ post.save! }.not_to raise_error
			end
		end
	end

end