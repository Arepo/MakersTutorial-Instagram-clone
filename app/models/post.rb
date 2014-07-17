class Post < ActiveRecord::Base

	belongs_to :user
	has_many :likes

	has_and_belongs_to_many :tags

	has_attached_file :picture,
		styles: { thumb: '300x300>' },
		storage: :s3,
		s3_credentials: {
			bucket: 'instagram_sasha',
			access_key_id: Rails.application.secrets.s3_access_key,
			secret_access_key: Rails.application.secrets.s3_secret_key
		}

	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

	def tag_names
		''
	end

	def tag_names=(tag_names)
		return nil if tag_names == ""		
		tag_names.split(/[, ]+/).uniq.each do |tag|
			formatted_name = '#' + tag.delete('#')
			tags << Tag.find_or_create_by(name: formatted_name)
		end
	end

end
