class HomeController < ApplicationController
	def index
		@photos = Photo.find(:all, :order => "id desc", :limit => 5)
	end
end
