class HomeController < ApplicationController
	def index
		@photos = Photo.get(:all, :order => "id desc", :limit => 5)
	end
end
