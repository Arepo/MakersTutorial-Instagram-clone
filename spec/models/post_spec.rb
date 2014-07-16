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

			it 'prepends a tag with #' do
				post.tag_names = 'yolo'
				tag = post.tags.last
				expect(tag.name).to eq '#yolo'
			end
		end

		describe 'multiple tags that don\'t already exist' do
			it 'adds two tags to post' do
				post.tag_names = 'raven, sailor'
				expect(post.tags.length).to eq 2
			end
		end

		describe 'tags that already exist' do
				let!(:tag) { Tag.create(name: '#ponies') }

			it 'reuses tags if they already exist' do
				post.tag_names = 'ponies'
				expect(post.tags).to include tag
				expect(Tag.count).to eq 1
			end
		end

		describe 'multiple duplicate tags' do
			it 'uses only unique tags' do
				post.tag_names = 'yolo, swag, yolo'
				expect(post.tags.count).to eq 2
			end
		end

		describe 'multiple comma separated tags' do
			context 'without spaces' do
				it 'adds each tag to the post' do
					post.tag_names = 'yolo,swag'
					expect(post.tags.count).to eq 2
				end
			end
		end
	end
end