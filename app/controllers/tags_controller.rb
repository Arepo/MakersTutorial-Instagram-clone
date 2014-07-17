class TagsController < ApplicationController

	def show
		hashtag = '#' + params[:id]
		@tag = Tag.find_by_name hashtag
	end

end
