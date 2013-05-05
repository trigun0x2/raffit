class ItemsController < ApplicationController
	before_filter :require_login
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      	respond_to do |format|
		    format.html { redirect_to item_url }
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

end
