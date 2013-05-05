class ItemsController < ApplicationController
	before_filter :require_login
  def new
    @item = Item.new
  end

  def create
    upload = params[:upload]
    @item = Item.new(params[:item])
    if @item.save

        # insert all applicable images into db
        i = 1
        until upload["img#{i}"].nil? do
          Photo.upload(@item.id, upload["img#{i}"])
          i += 1
        end
        #

      	respond_to do |format|
		    format.html { redirect_to @item }
		    format.js
  		end

    else
      render :new
    end
  end

  def show
  	@item = Item.find(params[:id])  	
  end

  def list
  	@items = Item.paginate(:page => params[:page], :per_page => 10)
  end

  def buyticket
    @ticket = Ticket.new
  end

end
