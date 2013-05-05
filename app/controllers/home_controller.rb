class HomeController < ApplicationController
	def index
		@photos = Photo.get(:all, :order => "id desc", :limit => 20)
	end
end
